import XCTest
import UIKit
@testable import UI

class RatesViewControllerTests: XCTestCase {

    func test_is_hidden_on_start() throws {
        let sb = UIStoryboard(name: "Rates", bundle: Bundle(for: RatesViewController.self))
        let sut = sb.instantiateViewController(identifier: "RatesViewController") as! RatesViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
}
