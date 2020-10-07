import Foundation
import Domain
import UI

public final class RatesComposer {
    static func composeControllerWith(listQuotes: ListQuotes) -> RatesViewController {
        return ControllerFactory.makeController(listQuotes: listQuotes)
    }
}
