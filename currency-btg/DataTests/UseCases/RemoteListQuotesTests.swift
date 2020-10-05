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
        let exp = expectation(description: "waiting")
        sut.list() { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .unexpected)
            case .success: XCTFail("Expected error received \(result) instead")
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithError(.noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_list_should_complete_with_data_if_client_complete_with_data() throws {
        let (sut, httpClientSpy) = makeSut()

        let expectedData = makeQuotesModel()
        let exp = expectation(description: "waiting")
        sut.list() { result in
            switch result {
            case .failure: XCTFail("Expected success received \(result) instead")
            case .success(let receivedData): XCTAssertEqual(receivedData, expectedData)
            }
            exp.fulfill()
        }
        httpClientSpy.completeWithData(expectedData.toData()!)
        wait(for: [exp], timeout: 1)
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
