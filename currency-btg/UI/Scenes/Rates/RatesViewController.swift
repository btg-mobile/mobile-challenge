import Foundation
import UIKit
import Presenter

class RatesViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var listQuotes: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        listQuotes?()
    }
}

extension RatesViewController: LoadingView {
    func display(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.stopAnimating()
        }
    }
}

extension RatesViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        
    }
}
