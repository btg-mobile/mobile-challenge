import Foundation
import UI
import Presenter
import Domain

class ControllerFactory {
    static func makeController(listQuotes: ListQuotes) -> RatesViewController {
        let controller = RatesViewController.instantiate()
        let presenter = RatesPresenter(alertView: WeakVarProxy(controller), listQuotes: listQuotes, loadingView: WeakVarProxy(controller))
        controller.listQuotes = presenter.list
        return controller
    }
}
