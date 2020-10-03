//
//  Cache.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

/// Object responsible for caching network responses.
final class Cache {

    /// The queue used to perform caching and loading from cache.
    private let queue: DispatchQueue = DispatchQueue(label: "cache")

    @UserDefaultAccess(key: "cache", defaultValue: false)
    private var hasCacheStorage: Bool

    /// The type of response being cached or loaded.
    enum Response: String {
        case live = "live-response"
        case list = "list-response"
    }

    /// Initializes a new instance of this type.
    init() {}

    /// Whether or not an instance of `Cache` has data saved.
    var hasCache: Bool {
        return hasCacheStorage
    }

    /// Caches an `Encodable` type.
    func cache<T: Encodable>(_ encodable: T, for type: T.Type, completion: @escaping (CacheError?) -> Void) {
        queue.async { [weak self] in
            guard let self = self else { return }
            if type == ListCurrencyResponse.self {
                do {
                    let data = try JSONEncoder().encode(encodable)
                    self.save(data, as: .list) { (error) in
                        if error != nil {
                            completion(error)
                        } else {
                            completion(nil)
                        }
                    }
                } catch {
                    completion(.unexpectedType)
                }
            }

            if type == LiveCurrencyReponse.self {
                do {
                    let data = try JSONEncoder().encode(encodable)
                    self.save(data, as: .live) { (error) in
                        if error != nil {
                            completion(error)
                        } else {
                            completion(nil)
                        }
                    }
                } catch {
                    completion(.unexpectedType)
                }
            }
        }
    }

    /// Loads a `Decodable` type from cache.
    func load<T: Decodable>(_ response: Cache.Response, for type: T.Type, completion: @escaping (Result<T, CacheError>) -> Void) {
        let cacheURL = FileManager.documentDirectory
        let fileURL = cacheURL.appendingPathComponent(response.rawValue).appendingPathExtension("json")

        switch response {
        case .list:
            do {
                let data = try Data(contentsOf: fileURL)
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.failedToLoad))
            }
        case .live:
            do {
                let data = try Data(contentsOf: fileURL)
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.failedToLoad))
            }
        }
    }

    /// Saves to cache.
    private func save(_ data: Data, as response: Cache.Response, completion: @escaping (CacheError?) -> Void) {
        let cacheURL = FileManager.documentDirectory
        let fileURL = cacheURL.appendingPathComponent(response.rawValue).appendingPathExtension("json")

        do {
            try data.write(to: fileURL, options: .atomicWrite)
            hasCacheStorage = true
            completion(nil)
        } catch {
            completion(.failedToSave)
        }
    }
}
