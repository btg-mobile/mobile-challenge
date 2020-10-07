import XCTest
import Domain
import Presenter

class RatesTests: XCTestCase {

    func test_() throws {
      
    }
}

extension RatesTests {
    
    func makeSut() -> (sut: RatesPresenter, alertViewSpy: AlertViewSpy) {
        let alertViewSpy = AlertViewSpy()
        let sut = RatesPresenter(alertView: alertViewSpy)
        return (sut, alertViewSpy)
    }
    
    class AlertViewSpy: AlertView {
        var viewModel: AlertViewModel?
        
        func showMessage(viewModel: AlertViewModel) {
            self.viewModel = viewModel
        }
    }
}
