//
//  NetworkModels.swift
//  Translater
//
//  Created by Booharin on 19.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import Foundation

struct TranslateResponse: Decodable {
    let id: Int
    let text: String
    let meanings: [TranslateMeaning]
}

struct TranslateMeaning: Decodable {
    let translation: WordTranslation
    let imageUrl: String?
}

struct WordTranslation: Decodable {
    let text: String
    let note: String?
}

