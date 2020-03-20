//
//  MockTranslateService.swift
//  TranslaterTests
//
//  Created by Booharin on 20.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import Foundation
import XCTest

@testable import Translater

final class MockTranslateService {
    var translateService = TranslateService(environment: EnvironmentImp.Release())
    
    func translateWordGo(completion:@escaping ([TranslateMeaning]?) -> ()) {
        translateService.translate(word: "go") { meanings in
            completion(meanings)
        }
    }
}
