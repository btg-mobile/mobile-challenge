import Foundation
import Domain

public class RatesPresenter {
    private let alertView: AlertView
    private let listQuotes: ListQuotes
    
    public init(alertView: AlertView, listQuotes: ListQuotes) {
        self.alertView = alertView
        self.listQuotes = listQuotes
    }
    
    public func list() {
        listQuotes.list { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            case .success: break
            }
        }
    }
}
