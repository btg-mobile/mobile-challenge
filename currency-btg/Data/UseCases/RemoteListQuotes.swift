import Foundation
import Domain
public final class RemoteListQuotes: ListQuotes {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func list(completion: @escaping (Result<QuotesModel ,DomainError>) -> Void) {
        httpClient.get(to: url) { error in
            completion(.failure(.unexpected))
        }
    }
}
