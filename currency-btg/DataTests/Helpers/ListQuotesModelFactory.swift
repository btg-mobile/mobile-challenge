import Foundation
import Domain

func makeQuotesModel() -> QuotesModel {
    return QuotesModel(timestemp: Date(), source: "USD", quotes: ["USD": 1.0])
}
