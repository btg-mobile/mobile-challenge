import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    static func makeRemoteListQuotes() -> ListQuotes {
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "http://api.currencylayer.com/live?access_key=84f27abb6cf24ff40e48b6d1c1e09570")!
        return RemoteListQuotes(url: url, httpClient: alamofireAdapter)
    }
}
