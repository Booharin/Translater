//
//  TranslaterTests.swift
//  TranslaterTests
//
//  Created by Booharin on 17.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import XCTest
@testable import Translater

class TranslaterTests: XCTestCase {
    
    func testTranlateWord() {
        let translateService = MockTranslateService()
        
        translateService.translateWordGo() { translateMeanings in
            XCTAssertNotNil(translateMeanings, "Expected meanings are loaded and not nil at this point")
        }
    }

}
