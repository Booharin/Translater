//
//  EnvironmentImp.swift
//  Translater
//
//  Created by Booharin on 18.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//
import Foundation

struct EnvironmentImp {
    private init(){}
}

extension EnvironmentImp {
    
    struct Debug: Environment {
        let baseUrl = URL(string: "https://dictionary.skyeng.ru/api/public/v1/")!
    }
    
    struct Release: Environment {
        let baseUrl = URL(string: "https://dictionary.skyeng.ru/api/public/v1/")!
    }
    
}
