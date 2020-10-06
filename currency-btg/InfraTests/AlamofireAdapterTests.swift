import XCTest
import Alamofire
import Data

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    
    func get(to url: URL, completion: @escaping (Result<Data, HttpError>) -> Void) {
        session.request(url, method: .get).responseData { dataResponse in
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success: break
            }
        }
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
    
    func test_get_should_complete_with_error_when_request_completes_with_error() throws {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: nil, response: nil, error: makeError())
        let exp = expectation(description: "waiting")
        sut.get(to: makeUrl()) { result in
            switch result {
            case .failure(let error): XCTAssertEqual(error, .noConnectivity)
            case .success: XCTFail("Expected error got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.get(to: url) { _ in exp.fulfill() }
        var request: URLRequest?
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
}

class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func observerRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override open func startLoading() {
        UrlProtocolStub.emit?(request)
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
