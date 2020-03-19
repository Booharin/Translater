//
//  TranslateService.swift
//  Translater
//
//  Created by Booharin on 19.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import Alamofire

struct TranslateService {
    
    private let router: TranslateRouter
    
    init(environment: Environment) {
        router = TranslateRouter(environment: environment)
    }
    
    func translate(word: String, completion:@escaping ([TranslateMeaning]?) -> ()) {
        do {
            AF.request(try router.translate(pageSize: 1,
                                            page: 1,
                                            word: word).asURLRequest())
                .responseJSON(queue: .global()) { response in
                    #if DEBUG
                    print(response)
                    #endif
                    
                    guard let data = response.data else { return }
                    
                    do {
                        let translateResponse = try JSONDecoder().decode([TranslateResponse].self, from: data)
                        #if DEBUG
                        print(translateResponse)
                        #endif
                        let arrayOfMeanings = translateResponse.map { $0.meanings }
                        let meanings = arrayOfMeanings.reduce([],+)
                        completion(meanings)
                    } catch {
                        #if DEBUG
                        print(error)
                        #endif
                        completion(nil)
                    }
            }
        } catch {
            #if DEBUG
            print(error)
            #endif
            completion(nil)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
