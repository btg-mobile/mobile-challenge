import XCTest

class RemoteListQuotes {
    private let url: URL
    private let httpClient: HttpGetClient
    
    init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    func list() {
        httpClient.get(url: url)
    }
}

protocol HttpGetClient {
    func get(url: URL)
}

class RemoteListQuotesTests: XCTestCase {

    func test_list_should_call_httpClient_with_correct_url() throws {
        let url = URL(string: "http://any-url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteListQuotes(url: url, httpClient: httpClientSpy)
        
        sut.list()
        
        XCTAssertEqual(httpClientSpy.url, url)
    }
    
    class HttpClientSpy: HttpGetClient {
        var url: URL?
        
        func get(url: URL) {
            self.url = url
        }
    }
}
