import Foundation

public struct QuotesModel: Model, Decodable {
    
    public typealias QuotesKey = String
    
    public var timestemp: Date
    public var source: String
    public var quotes: [QuotesKey: Double]
    
    public init(timestemp: Date, source: String, quotes: [QuotesKey: Double]) {
        self.timestemp = timestemp
        self.source = source
        self.quotes = quotes
    }
}
