import XCTest
import Domain
import Presenter

class RatesTests: XCTestCase {

    func test_rates_should_show_error_message_if_listQuotes_fails() throws {
        let alertViewSpy = AlertViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = makeSut(alertView: alertViewSpy, listQuotes: listQuotesSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeErrorAlertViewModel(message: "Algo inesperado aconteceu, tente novamente em alguns instantes."))
            exp.fulfill()
        }
        sut.list()
        listQuotesSpy.completedWithError(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_rates_should_show_loading_before_and_after_call_listQuotes() throws {
        let loadingViewSpy = LoadingViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = makeSut(listQuotes: listQuotesSpy, loadingView: loadingViewSpy)
        let exp = expectation(description: "waiting")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: true))
            exp.fulfill()
        }
        sut.list()
        wait(for: [exp], timeout: 1)
        let expHiddenLoading = expectation(description: "waiting")
        loadingViewSpy.observer { viewModel in
            XCTAssertEqual(viewModel, LoadingViewModel(isLoading: false))
            expHiddenLoading.fulfill()
        }
        listQuotesSpy.completedWithError(.unexpected)
        wait(for: [expHiddenLoading], timeout: 1)
    }
    
    func test_rates_should_show_success_message_if_listQuotes_succeeds() throws {
        let alertViewSpy = AlertViewSpy()
        let listQuotesSpy = ListQuotesSpy()
        let sut = makeSut(alertView: alertViewSpy, listQuotes: listQuotesSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observer { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeSuccessAlertViewModel(message: "Cotas baixadas com sucesso."))
            exp.fulfill()
        }
        sut.list()
        listQuotesSpy.completedWithData(makeQuotesModel())
        wait(for: [exp], timeout: 1)
    }
}

extension RatesTests {
    
    func makeSut(alertView: AlertViewSpy = AlertViewSpy(), listQuotes: ListQuotesSpy = ListQuotesSpy(), loadingView: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> RatesPresenter {

        let sut = RatesPresenter(alertView: alertView, listQuotes: listQuotes, loadingView: loadingView)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func makeErrorAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: message)
    }
    
    func makeSuccessAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Sucesso", message: message)
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
        
        func completedWithData(_ quotes: QuotesModel) {
            completion?(.success(quotes))
        }
    }
    
    class LoadingViewSpy: LoadingView {
        var emit: ((LoadingViewModel) -> Void)?
        
        func observer(completion: @escaping (LoadingViewModel) -> Void) {
            self.emit = completion
        }
        
        func display(viewModel: LoadingViewModel) {
            self.emit?(viewModel)
        }
    }
}
