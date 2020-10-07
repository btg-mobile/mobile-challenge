import XCTest
import UIKit
import Presenter
@testable import UI

class RatesViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        let sb = UIStoryboard(name: "Rates", bundle: Bundle(for: RatesViewController.self))
        let sut = sb.instantiateViewController(identifier: "RatesViewController") as! RatesViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() throws {
        let sb = UIStoryboard(name: "Rates", bundle: Bundle(for: RatesViewController.self))
        let sut = sb.instantiateViewController(identifier: "RatesViewController") as! RatesViewController
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut as LoadingView)
    }
}
