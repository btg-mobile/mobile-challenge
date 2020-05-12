//
//  API.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class API {

    static let instance = API()

    private init() {}

    private let url = "http://api.currencylayer.com"
    private let apiKey = "473839a553f3bdc8b40c316043562398"

    static func get() {

    }

    private lazy var queryItems = [
        URLQueryItem(name: "access_key", value: self.apiKey)
    ]

    func get(
        path: String,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        guard var urlComponenet = URLComponents(string: "\(self.url)\(path)") else { return }

        urlComponenet.queryItems = self.queryItems

        guard let url = urlComponenet.url else { return }

        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }

}
