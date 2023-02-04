//
//  Constants.swift
//  ImageGenie
//
//  Created by berkehan ozturk on 23.12.2022.
//

import Foundation
struct Constants {
    static let API_BASE_URL = "https://api.openai.com/v1"
    static let testCreate = "test/create"
}

struct NetworkConfig {
    static let requestDefaultHeaders = ["Content-Type": "application/json","Authorization": "Bearer \(NetworkConfig.auth)"]
    static let auth = "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"
}
