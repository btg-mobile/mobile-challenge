import XCTest
import Main
class RatesIntegrationTests: XCTestCase {

    func test_ui_presentation_integration() throws {
        let sut = RatesComposer.composeControllerWith(listQuotes: ListQuotesSpy())
        checkMemoryLeak(for: sut)
    }

}
