import XCTest
@testable import BudouX

final class ParserParseTests: XCTestCase {

    let TEST_SENTENCE = "abcdeabcd"

    func testShouldSeparateButNotTheFirstTwoCharacters() throws {
        let model = [
            "UW4:a": 10000 // means "should separate right before 'a'".
        ]
        let parser = Parser(model: model)
        let result = parser.parse(sentence: TEST_SENTENCE)
        XCTAssertEqual(result, ["abcde", "abcd"])
    }

    func testShouldRespectTheResultsFeatureWithAHighScore() throws {
        let model = [
            "BP2:UU": 10000 // previous results are Unknown and Unknown.
        ]
        let parser = Parser(model: model)
        let result = parser.parse(sentence: TEST_SENTENCE)
        XCTAssertEqual(result, ["abc", "deabcd"])

    }

    func testShouldIgnoreFeaturesWithScoresLowerThanTheThreshold() throws {
        let model = ["UW4:a": 10]
        let parser = Parser(model: model)
        let result = parser.parse(sentence: TEST_SENTENCE, thres: 100)
        XCTAssertEqual(result, [TEST_SENTENCE])

    }

    func testShouldReturnABlankListWhenTheInputIsBlank() throws {
        let model: [String: Int] = [:]
        let parser = Parser(model: model)
        let result = parser.parse(sentence: "")
        XCTAssertTrue(result.isEmpty)
    }
}
