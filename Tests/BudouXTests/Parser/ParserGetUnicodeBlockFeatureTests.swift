import XCTest

@testable import BudouX

final class ParserGetUnicodeBlockFeatureTests: XCTestCase {

    // MARK: - Helper

    func testFeature(_ character: String, _ feature: String) {
        let result = Parser.getUnicodeBlockFeature(character)
        XCTAssertEqual(result, feature)
    }

    // MARK: - Test

    func testAShouldBeThe1stBlockBasicLatine() throws {
        testFeature("a", "001")
    }

    func testあShouldBeThe108thBlockHiragana() throws {
        testFeature("あ", "108")
    }

    func test安ShouldBeThe120thBlockKanji() throws {
        testFeature("安", "120")
    }

    func testOnlyTheFirstCharacterShouldBeRecognized() throws {
        testFeature("あ安", "108")
    }

    func testShouldReturnINVALIDWhenABlankStringIsGiven() throws {
        testFeature("", invalid)
    }

    func testShouldReturnINVALIDWhenINVALIDIsGiven() throws {
        testFeature(invalid, invalid)
    }
}
