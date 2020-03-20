//
//  TranslateRouter.swift
//  Translater
//
//  Created by Booharin on 19.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import Alamofire

struct TranslateRouter {
    private let environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    func translate(pageSize: Int,
                   page: Int,
                   word: String) -> URLRequestConvertible {
        
        return Translate(environment: environment,
                         pageSize: pageSize,
                         page: page,
                         word: word)
    }
}

extension TranslateRouter {
    
    private struct Translate: RequestRouter {
        let environment: Environment
        let pageSize: Int
        let page: Int
        let word: String
        
        init(environment: Environment, pageSize: Int, page: Int, word: String) {
            self.environment = environment
            self.pageSize = pageSize
            self.page = page
            self.word = word
        }
        
        var baseUrl: URL {
            return environment.baseUrl
        }
        
        let method: HTTPMethod = .get
        
        var path = NetworkMethods.search.rawValue
        
        var parameters: Parameters {
            return [
                "pageSize" : pageSize,
                "page" : page,
                "search" : word
            ]
        }
    }
}
