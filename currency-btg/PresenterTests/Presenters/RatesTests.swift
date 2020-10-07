import XCTest
import Domain
import Presenter

class RatesTests: XCTestCase {

    func test_rates_should_show_error_message_if_listQuotes_fails() throws {
        let (sut, alertViewSpy, listQuotesSpy) = makeSut()
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.list()
        listQuotesSpy.completedWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
}

extension RatesTests {
    
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: RatesPresenter, alertViewSpy: AlertViewSpy, listQuotesSpy: ListQuotesSpy) {
        let alertViewSpy = AlertViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = RatesPresenter(alertView: alertViewSpy, listQuotes: listQuotesSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return (sut, alertViewSpy, listQuotesSpy)
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: message)
    }
    
    class AlertViewSpy: AlertView {
        var emit: ((AlertViewModel) -> Void)?
        
        func observer(completion: @escaping (AlertViewModel) -> Void) {
            self.emit = completion
        }
        
        func showMessage(viewModel: AlertViewModel) {
            self.emit?(viewModel)
        }
    }
    
    class ListQuotesSpy: ListQuotes {
        var completion: ((Result<QuotesModel, DomainError>) -> Void)?

        func list(completion: @escaping (Result<QuotesModel, DomainError>) -> Void) {
            self.completion = completion
        }

        func completedWithError(_ error: DomainError) {
            completion?(.failure(error))
        }
    }
}
