import Foundation

protocol ListQuotes {
    func list(completion: @escaping (Result<QuotesModel, Error>) -> Void)
}
