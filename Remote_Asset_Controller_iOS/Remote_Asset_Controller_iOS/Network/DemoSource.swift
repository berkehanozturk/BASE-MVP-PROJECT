//
//  DemoSource.swift
//  ImageGenie
//
//  Created by berkehan ozturk on 23.12.2022.
//

import Foundation
import Moya
import Alamofire

public protocol TestResource {
    func test(payload: TestPayload, completion: @escaping Completion<TestResponse>)
}

public struct TestResourceImpl: TestResource {
    
    private let service: BaseService
    
    public init() {
        self.service = BaseService()
    }
    
    public func test(payload: TestPayload, completion: @escaping Completion<TestResponse>) {
        service.request(MultiTarget(TestTarget.create(payload: payload)), completion: completion)
    }
}

enum TestTarget {
    case create(payload: TestPayload)
}

extension TestTarget: TargetType {
  
    
    
    var offlineable: Bool {
        return true
    }
    
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .create:
            return Constants.testCreate
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .create(let payload):
            return .requestJSONEncodable(payload)
        }
    }
    
    var headers: [String : String]? {
        return NetworkConfig.requestDefaultHeaders
    }
}
