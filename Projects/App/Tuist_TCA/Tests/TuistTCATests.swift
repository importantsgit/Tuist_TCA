import ComposableArchitecture
import XCTest

@testable import Tuist_TCA

final class TuistTCATests: XCTestCase {

    override func setUp() async throws {

    }

    func testCounter() async {
        let sut = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        await sut.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await sut.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
