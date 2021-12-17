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
        testFeature("あ", "108")
    }

    func testShouldProcessTheFirstCharacterOnly() throws {
        testFeature("あ亜。", "108")
    }

    func testShouldReturnIn3DigitsEvenIfTheIndexIsSmall() throws {
        testFeature("a", "001");
    }

    func testShouldReturnTheDefaultValueIfTheCodePointIsUndefined() throws {
        testFeature("", "999");
    }
}
