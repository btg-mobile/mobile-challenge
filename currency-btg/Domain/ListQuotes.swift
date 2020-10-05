import Foundation

public protocol ListQuotes {
    func list(completion: @escaping (Result<QuotesModel, Error>) -> Void)
}
