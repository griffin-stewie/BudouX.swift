import XCTest

@testable import BudouX

final class UtilsTests: XCTestCase {

    let arr = [1, 3, 8, 12, 34]

    func testShouldFindThePointWhenTheItemIsIncluded() throws {
        testInsertionPoint(item: 8, expectedPoint: 3)
    }

    func testShouldFindThePointWhenTheItemIsNotIncluded() throws {
        testInsertionPoint(item: 4, expectedPoint: 2)
    }

    func testShouldReturnZeroWhenTheItemIsTheSmallest() throws {
        testInsertionPoint(item: -100, expectedPoint: 0)
    }

    func testShouldReturnTheArrayLengthWhenTheItemIsTheBiggest() throws {
        testInsertionPoint(item: 100, expectedPoint: arr.count)
    }
}

extension UtilsTests {
    fileprivate func testInsertionPoint(item: Int, expectedPoint: Int) {
        let point = bisectRight(arr: arr, i: item)
        XCTAssertEqual(point, expectedPoint)
    }
}
