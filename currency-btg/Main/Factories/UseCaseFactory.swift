import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = "http://api.currencylayer.com"
    private static let apiKey = "84f27abb6cf24ff40e48b6d1c1e09570"
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)?access_key=\(apiKey)")!
    }
    static func makeRemoteListQuotes() -> ListQuotes {
        return RemoteListQuotes(url: makeUrl(path: "live"), httpClient: httpClient)
    }
}
