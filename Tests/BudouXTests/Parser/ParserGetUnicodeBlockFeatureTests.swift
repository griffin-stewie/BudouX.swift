import XCTest

@testable import BudouX

final class ParserGetUnicodeBlockFeatureTests: XCTestCase {

    // MARK: - Helper

    func testFeature(_ character: String, _ feature: String) {
        let result = Parser.getUnicodeBlockFeature(character)
        XCTAssertEqual(result, feature)
    }

    // MARK: - Test

    func testShouldEncodeTheCharacterToAUnicodeBlockIndex() throws {
        testFeature("γ", "108")
    }

    func testShouldProcessTheFirstCharacterOnly() throws {
        testFeature("γδΊγ", "108")
    }

    func testShouldReturnIn3DigitsEvenIfTheIndexIsSmall() throws {
        testFeature("a", "001")
    }

    func testShouldReturnTheDefaultValueIfTheCodePointIsUndefined() throws {
        testFeature("", "999")
    }
}
