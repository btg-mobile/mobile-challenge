import Foundation

public struct QuotesModel {
    
    public typealias QuotesKey = String
    
    public var timestemp: Date
    public var source: String
    public var quotes: [QuotesKey: Double]
}
