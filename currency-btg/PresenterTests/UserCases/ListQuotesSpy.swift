import Foundation
import Domain

class ListQuotesSpy: ListQuotes {
    var completion: ((Result<QuotesModel, DomainError>) -> Void)?

    func list(completion: @escaping (Result<QuotesModel, DomainError>) -> Void) {
        self.completion = completion
    }

    func completedWithError(_ error: DomainError) {
        completion?(.failure(error))
    }
    
    func completedWithData(_ quotes: QuotesModel) {
        completion?(.success(quotes))
    }
}
