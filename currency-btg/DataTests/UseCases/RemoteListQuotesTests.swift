import XCTest
import Domain
import Data

class RemoteListQuotesTests: XCTestCase {

    func test_list_should_call_httpClient_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        
        sut.list() { _ in }
        
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_list_should_complete_with_error_if_client_fails() throws {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_list_should_complete_with_data_if_client_complete_with_valid_data() throws {
        let (sut, httpClientSpy) = makeSut()

        let expectedData = makeQuotesModel()
        expect(sut, completeWith: .success(expectedData)) {
            httpClientSpy.completeWithData(expectedData.toData()!)
        }
    }
    
    func test_list_should_complete_with_error_if_client_complete_with_invalid_data() throws {
        let (sut, httpClientSpy) = makeSut()
        
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(Data("invalid_data".utf8))
        }
    }
}

extension RemoteListQuotesTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteListQuotes, httpClientSpy: HttpClientSpy) {
        
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteListQuotes(url: url, httpClient: httpClientSpy)
        
        return (sut, httpClientSpy)
    }
    
    func makeQuotesModel() -> QuotesModel {
        QuotesModel(timestemp: Date(), source: "USD", quotes: ["USD": 1.0])
    }
    
    func expect(_ sut: RemoteListQuotes, completeWith expectedResult: Result<QuotesModel, DomainError>, when action: () -> Void) {
       
        let exp = expectation(description: "waiting")
        sut.list() { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError)
            case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(expectedData, receivedData)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead")
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
    
    class HttpClientSpy: HttpGetClient {
        var urls = [URL]()
        var completion: ((Result<Data, HttpError>) -> Void)?
        
        func get(to url: URL, completion: @escaping (Result<Data, HttpError>) -> Void) {
            self.urls.append(url)
            self.completion = completion
        }
        
        func completeWithError(_ error: HttpError) {
            self.completion?(.failure(error))
        }
        
        func completeWithData(_ data: Data) {
            self.completion?(.success(data))
        }
    }
}
