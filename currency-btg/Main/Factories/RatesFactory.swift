import Foundation
import UI
import Presenter
import Data
import Infra

class RatesFactory {
    static func makeController() -> RatesViewController {
        let controller = RatesViewController.instantiate()
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "http://api.currencylayer.com/live?access_key=84f27abb6cf24ff40e48b6d1c1e09570")!
        let remoteListQuotes = RemoteListQuotes(url: url, httpClient: alamofireAdapter)
        let presenter = RatesPresenter(alertView: controller, listQuotes: remoteListQuotes, loadingView: controller)
        controller.listQuotes = presenter.list
        return controller
    }
}
