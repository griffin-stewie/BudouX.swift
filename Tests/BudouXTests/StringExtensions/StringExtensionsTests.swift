import XCTest

@testable import BudouX

final class StringExtensionsTests: XCTestCase {

    func testJSSlice() throws {
        let str = "The quick brown fox jumps over the lazy dog."

        XCTAssertNil(str.slice(0, 0))
        XCTAssertNil(str.slice(1, 1))

        XCTAssertEqual(str.slice(31), "the lazy dog.")
        XCTAssertEqual(str.slice(0, 1), "T")
        XCTAssertEqual(str.slice(0, 2), "Th")
        XCTAssertEqual(str.slice(4, 19), "quick brown fox")
    }

    func testJSSlice2() throws {
        let str = "The morning is upon us."
        
        XCTAssertEqual(str.slice(1, 8), "he morn")
        XCTAssertEqual(str.slice(12), "is upon us.")
        XCTAssertEqual(str.slice(30), nil)
    }

    func testNegativeJSSlice() throws {
        let str = "The quick brown fox jumps over the lazy dog."

        XCTAssertEqual(str.slice(-4), "dog.")
        XCTAssertEqual(str.slice(-9, -5), "lazy")
    }

    func testNegativeJSSlice2() throws {
        let str = "The morning is upon us."

        XCTAssertEqual(str.slice(-3, 0), nil)
        XCTAssertEqual(str.slice(4, -2), "morning is upon u")
        XCTAssertEqual(str.slice(-3), "us.")
        XCTAssertEqual(str.slice(-3, -1), "us")
        XCTAssertEqual(str.slice(0, -1), "The morning is upon us")
        XCTAssertEqual(str.slice(4, -1), "morning is upon us")
    }

    func testJSSliceIndexEndOverCount() throws {
        let str = "a"
        XCTAssertEqual(str.slice(0, 1), "a")
    }

    func testStringAt() throws {
        let str = "Hello World"
        XCTAssertEqual(str.string(at: 0), "H")
        XCTAssertEqual(str.string(at: 1), "e")
        XCTAssertEqual(str.string(at: 2), "l")
        XCTAssertEqual(str.string(at: 3), "l")
        XCTAssertEqual(str.string(at: 4), "o")
        XCTAssertEqual(str.string(at: 5), " ")
        XCTAssertEqual(str.string(at: 6), "W")
        XCTAssertEqual(str.string(at: 7), "o")
        XCTAssertEqual(str.string(at: 8), "r")
        XCTAssertEqual(str.string(at: 9), "l")
        XCTAssertEqual(str.string(at: 10), "d")
        XCTAssertNil(str.string(at: 11))
        XCTAssertNil(str.string(at: -1))
    }
}
