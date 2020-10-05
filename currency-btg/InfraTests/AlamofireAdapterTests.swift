import XCTest
import Alamofire

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    func get(to url: URL) {
        session.request(url, method: .get).resume()
    }
}

class AlamofireAdapterTests: XCTestCase {

    func test_get_should_make_request_with_correct_url_and_method() throws {
        testRequestFor { request in
            let url = makeUrl()
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
}

extension AlamofireAdapterTests {
    func makeSut() -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        return AlamofireAdapter(session: session)
    }
    
    func testRequestFor(url: URL = makeUrl(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        sut.get(to: url)
        let exp = expectation(description: "waiting")
        UrlProtocolStub.observerRequest { request in
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override open func startLoading() {
        UrlProtocolStub.emit?(request)
    }
    
    override func stopLoading() {
        
    }
}
