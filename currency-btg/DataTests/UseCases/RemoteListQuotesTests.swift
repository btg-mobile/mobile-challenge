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
            httpClientSpy.completeWithData(makeInvalidData())
        }
    }
}

extension RemoteListQuotesTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteListQuotes, httpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteListQuotes(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
    func makeQuotesModel() -> QuotesModel {
        return QuotesModel(timestemp: Date(), source: "USD", quotes: ["USD": 1.0])
    }
    
    func makeInvalidData() -> Data {
        return Data("invalid_data".utf8)
    }
    
    func expect(_ sut: RemoteListQuotes, completeWith expectedResult: Result<QuotesModel, DomainError>, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
       
        let exp = expectation(description: "waiting")
        sut.list() { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)): XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
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
