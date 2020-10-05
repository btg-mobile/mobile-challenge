import XCTest
import Domain
import Data

class RemoteListQuotesTests: XCTestCase {

    func test_list_should_call_httpClient_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")!
        let (sut, httpClientSpy) = makeSut(url: url)
        
        sut.list()
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
}

extension RemoteListQuotesTests {
    func makeSut(url: URL = URL(string: "http://any-url.com")!) -> (sut: RemoteListQuotes, httpClientSpy: HttpClientSpy) {
        
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteListQuotes(url: url, httpClient: httpClientSpy)
        
        return (sut, httpClientSpy)
    }
    
    class HttpClientSpy: HttpGetClient {
        var url: URL?
        
        func get(to url: URL) {
            self.url = url
        }
    }
}
