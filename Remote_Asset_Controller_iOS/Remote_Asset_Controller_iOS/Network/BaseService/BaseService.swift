//
//  BaseService.swift
//  ImageGenie
//
//  Created by berkehan ozturk on 23.12.2022.
//

import Foundation
import Moya
import Alamofire

public typealias Completion<T: Decodable> = (Result<T?, BaseError>) -> Void

public struct BaseError: Error {
    public var message: String?
    public var errorCode: String?
    public var statusCode: Int?
    
    init(message: String?, errorCode: String? = nil, statusCode: Int?) {
        self.message = message
        self.errorCode = errorCode
        self.statusCode = statusCode
    }
}

public struct BaseService {
    
    private func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            if !data.isEmpty {
                let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                return String(data: prettyData, encoding: .utf8)!
            }
            else {
                return String(data: data, encoding: .utf8)!
            }
         
        } catch {
            return String(data: data, encoding: .utf8)! // fallback to original data if it can't be serialized.
        }
    }
    
    private func JSONRequestDataFormatter(_ data: Data) -> String {
        return JSONResponseDataFormatter(data)
    }
    
    private var provider: MoyaProvider<MultiTarget> {
        var plugins: [PluginType] = []
        
        #if DEBUG
        let config = NetworkLoggerPlugin.Configuration(formatter: NetworkLoggerPlugin.Configuration.Formatter(requestData: JSONRequestDataFormatter(_:), responseData: JSONResponseDataFormatter(_:)), logOptions: [.verbose, .formatRequestAscURL])
        let loggerPlugin = NetworkLoggerPlugin(configuration: config)
        plugins.append(loggerPlugin)
        #endif
        return MoyaProvider<MultiTarget>(plugins: plugins)
    }
    
    public func request<T: Codable>(_ target: MultiTarget, retryCount: Int = 1, completion: @escaping Completion<T>) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    if filteredResponse.data.isEmpty {
                        completion(.success(TestPayload() as? T))
                    } else {
                        let model = try filteredResponse.map(T.self, atKeyPath: nil, using: JSONDecoder())
                        completion(.success(model))
                    }
                } catch let error {
                    if let error = error as? MoyaError {
                        self.handleError(target, error: error, completion: completion)
                    } else {
                        let responseData = String(data: response.data, encoding: String.Encoding.utf8)

                        completion(.failure(BaseError(message: error.localizedDescription, statusCode: response.statusCode)))
                    }
                }
            case .failure(let error):
                self.handleError(target, error: error, completion: completion)
            }
        }
        
    }
    
    private func handleError<T: Codable>(_ target: MultiTarget, error: MoyaError, completion: @escaping Completion<T>) {
        #if DEBUG
        print(error)
        #endif

        let sharedInstance = NetworkReachabilityManager()!
        var isConnectedToInternet: Bool {
            return sharedInstance.isReachable
        }
        
        if isConnectedToInternet {
            if let customError = error.customError {
                completion(.failure(BaseError(message: customError.errorMessage, errorCode: customError.errorCode, statusCode: error.response?.statusCode)))
            }
            else  {
                completion(.failure(BaseError(message: error.localizedDescription, statusCode: error.response?.statusCode)))
            }
        }
        else {
            completion(.failure(BaseError(message: "NO Internet connection", statusCode: 502)))
        }
    
    }
}


extension MoyaError {
    public var customError: BackendError? {
        return response.flatMap {
            try? $0.map(BackendError.self)
        }
    }
}

public struct BackendError: Codable {
    public var success: Bool?
    public var errorMessage: String?
    public var errorCode: String?
}
