//
//  Utils.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import Foundation

class Utils {
    static func loadJson<T: Codable>(with json: String) -> T? {
        do {
            let path = Bundle(for: self).path(forResource: json, ofType: "json")!
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let models = try JSONDecoder().decode(T.self, from: data)
            return models
        } catch {
            return nil
        }
    }
}
