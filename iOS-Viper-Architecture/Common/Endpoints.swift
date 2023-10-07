//
//  Endpoints.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 19/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "http://localhost:3000"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Posts: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/posts"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
