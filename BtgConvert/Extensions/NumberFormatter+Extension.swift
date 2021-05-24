import Foundation

public extension NumberFormatter {
    static func create() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        
        return formatter
    }
}
