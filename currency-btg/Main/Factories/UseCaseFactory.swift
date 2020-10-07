import Foundation
import Data
import Infra
import Domain

final class UseCaseFactory {
    private static let httpClient = AlamofireAdapter()
    private static let apiBaseUrl = Environment.variable(.apiBaseUrl)
    private static let apiKey = Environment.variable(.apiKey)
    
    private static func makeUrl(path: String) -> URL {
        return URL(string: "\(apiBaseUrl)/\(path)?access_key=\(apiKey)")!
    }
    static func makeRemoteListQuotes() -> ListQuotes {
        let remoteListQuotes = RemoteListQuotes(url: makeUrl(path: "live"), httpClient: httpClient)
        return MainQueueDipatchDecorator(remoteListQuotes)
    }
}

public final class MainQueueDipatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
        
        
    }
}

extension MainQueueDipatchDecorator: ListQuotes where T: ListQuotes {
    public func list(completion: @escaping (Result<QuotesModel, DomainError>) -> Void) {
        instance.list { [weak self] result in
            self?.dispatch {
                completion(result)
            }
        }
    }
}
