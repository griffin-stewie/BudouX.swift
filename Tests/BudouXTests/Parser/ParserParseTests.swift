import XCTest

@testable import BudouX

final class ParserParseTests: XCTestCase {

    struct ModelForTest: Model {
        let supportedNaturalLanguages: Set<String> = []
        let featureAndScore: [String: Int]
    }

    let testSentence = "abcdeabcd"

    func testShouldSeparateIfAStrongFeatureItemSupports() throws {
        let model = ModelForTest(featureAndScore: [
            "UW4:a": 10000  // means "should separate right before 'a'".
        ])
        let parser = Parser(model: model)
        let result = parser.parse(sentence: testSentence)
        XCTAssertEqual(result, ["abcde", "abcd"])
    }

    func testShouldSeparateEvenIfItMakesTheFirstCharacterASolePhrase() throws {
        let model = ModelForTest(featureAndScore: [
            "UW4:b": 10000  // means "should separate right before 'b'".
        ])
        let parser = Parser(model: model)
        let result = parser.parse(sentence: testSentence)
        XCTAssertEqual(result, ["a", "bcdea", "bcd"])

    }

    func testShouldReturnABlankListWhenTheInputIsBlank() throws {
        let model = ModelForTest(featureAndScore: [:])
        let parser = Parser(model: model)
        let result = parser.parse(sentence: "")
        XCTAssertTrue(result.isEmpty)
    }

    func testSample1() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "この記事は、大学生限定クリエイティブコミュニティ GeekSalon Advent Calendar 2021 3 日目の記事です。")
        print(result)
        let expected = [
            "この",
            "記事は、",
            "大学生限定クリエイティブコミュニティ GeekSalon Advent Calendar 2021 3 日目の",
            "記事です。",
        ]
        XCTAssertEqual(result, expected)
    }

    func testSample2() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "あのイーハトーヴォのすきとおった風、夏でも底に冷たさをもつ青いそら、うつくしい森で飾られたモリーオ市、郊外のぎらぎらひかる草の波。")
        print(result)
        let expected = [
            "あの",
            "イーハトーヴォの",
            "すきと",
            "おった風、",
            "夏でも",
            "底に",
            "冷たさを",
            "もつ青いそら、",
            "うつくしい森で",
            "飾られた",
            "モリーオ市、",
            "郊外の",
            "ぎら",
            "ぎら",
            "ひかる",
            "草の波。",
        ]
        XCTAssertEqual(result, expected)
    }

    func testSample22() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "郊外のぎらぎらひかる草の波。")
        print(result)
        let expected = [
            "郊外の",
            "ぎら",
            "ぎら",
            "ひかる",
            "草の波。",
        ]
        XCTAssertEqual(result, expected)
    }


    func testSample3() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "Google の使命は、世界中の情報を整理し、世界中の人がアクセスできて使えるようにすることです。")
        print(result)
        let expected = [
            "Google の",
            "使命は、",
            "世界中の",
            "情報を",
            "整理し、",
            "世界中の",
            "人が",
            "アクセスできて",
            "使えるように",
            "する",
            "ことです。",
        ]
        XCTAssertEqual(result, expected)
    }
}
