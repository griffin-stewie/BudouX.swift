import XCTest

@testable import BudouX

final class ParserParseTests: XCTestCase {

    struct ModelForTest: Model {
        let supportedNaturalLanguages: Set<String> = []
        let featureAndScore: [String: [String: Int]]
    }

    let testSentence = "abcdeabcd"

    func testShouldSeparateIfAStrongFeatureItemSupports() throws {
        let model = ModelForTest(featureAndScore: [
            "UW4": ["a": 10000]  // means "should separate right before 'a'".
        ])
        let parser = Parser(model: model)
        let result = parser.parse(sentence: testSentence)
        XCTAssertEqual(result, ["abcde", "abcd"])
    }

    func testShouldSeparateEvenIfItMakesTheFirstCharacterASolePhrase() throws {
        let model = ModelForTest(featureAndScore: [
            "UW4": ["b": 10000]  // means "should separate right before 'b'".
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
            "すきとおった",
            "風、",
            "夏でも",
            "底に",
            "冷たさを",
            "もつ",
            "青い",
            "そら、",
            "うつくしい",
            "森で",
            "飾られた",
            "モリーオ市、",
            "郊外の",
            "ぎらぎら",
            "ひかる",
            "草の",
            "波。",
        ]
        XCTAssertEqual(result, expected)
    }

    func testSample22() throws {
        let parser = Parser()
        let result = parser.parse(sentence: "郊外のぎらぎらひかる草の波。")
        print(result)
        let expected = [
            "郊外の",
            "ぎらぎら",
            "ひかる",
            "草の",
            "波。",
        ]
        XCTAssertEqual(result, expected)
    }


    func testLoadDefaultJapaneseParser() throws {
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

    func testLoadDefaultSimplifiedChineseParser() throws {
        let parser = Parser(model: ZhHansModel())
        let result = parser.parse(sentence: "我们的使命是整合全球信息，供大众使用，让人人受益。")
        print(result)
        let expected = [
            "我们",
            "的",
            "使命",
            "是",
            "整合",
            "全球",
            "信息，",
            "供",
            "大众",
            "使用，",
            "让",
            "人",
            "人",
            "受益。",
        ]
        XCTAssertEqual(result, expected)
    }

    func testLoadDefaultTraditionalChineseParser() throws {
        let parser = Parser(model: ZhHantModel())
        let result = parser.parse(sentence: "我們的使命是匯整全球資訊，供大眾使用，使人人受惠。")
        print(result)
        let expected = [
            "我們",
            "的",
            "使命",
            "是",
            "匯整",
            "全球",
            "資訊，",
            "供",
            "大眾",
            "使用，",
            "使",
            "人",
            "人",
            "受惠。",
        ]
        XCTAssertEqual(result, expected)
    }

    func testLoadDefaultThaiParser() throws {
        let parser = Parser(model: ThModel())
        let result = parser.parse(sentence: "วันนี้อากาศดี")
        print(result)
        let expected = [
            "วัน",
            "นี้",
            "อากาศ",
            "ดี",
        ]

        XCTAssertEqual(result.count, expected.count)

        for i in result.indices {
            XCTAssertEqual(result[i], expected[i])
        }
    }
}
