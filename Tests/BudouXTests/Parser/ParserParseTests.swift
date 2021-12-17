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

    func testSample1() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "この記事は、大学生限定クリエイティブコミュニティ GeekSalon Advent Calendar 2021 3 日目の記事です。")
        print(result)
        XCTAssertEqual(result, ["この記事は、", "大学生限定クリエイティブコミュニティ GeekSalon Advent Calendar 2021 3 日目の", "記事です。"])
    }

    func testSample2() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい森で飾られたモリーオ市、郊外のぎらぎらひかる草の波。")
        print(result)
        let expected = [
            "あのイーハトーヴォの",
            "すきと",
            "おった",
            "風、",
            "夏でも",
            "底に",
            "冷たさを",
            "もつ",
            "青いそら、",
            "うつくしい",
            "森で",
            "飾られた",
            "モリーオ市、",
            "郊外の",
            "ぎらぎらひかる",
            "草の",
            "波。"
        ]
        XCTAssertEqual(result, expected)
    }
}
