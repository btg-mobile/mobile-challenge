import Foundation

struct QuotesModel {
    
    typealias QuotesKey = String
    
    var timestemp: Date
    var source: String
    var quotes: [QuotesKey: Double]
}
