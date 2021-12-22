import XCTest
@testable import BudouX

final class ParserTranslateToStringTests: XCTestCase {
    func testInsertWordJoinerBetweenEachCharacter() throws {
        let sample = "あなたに"
        let parser = Parser()
        let result = parser.insertWordJoinerBetweenEachCharacter(sample)
        let wordJoiner = Parser.wordJoiner
        XCTAssertEqual(result, "あ\(wordJoiner)な\(wordJoiner)た\(wordJoiner)に")
    }

    func testInsertSpaces() throws {
        let sample = ["あなたに", "寄り添う", "最先端の", "テクノロジー。"]
        let parser = Parser()
        let result = parser.insertSpaces(sample)
        let wordJoiner = Parser.wordJoiner
        let zeroWidthSpace = Parser.zeroWidthSpace
        let expected = "あ\(wordJoiner)な\(wordJoiner)た\(wordJoiner)に\(zeroWidthSpace)寄\(wordJoiner)り\(wordJoiner)添\(wordJoiner)う\(zeroWidthSpace)最\(wordJoiner)先\(wordJoiner)端\(wordJoiner)の\(zeroWidthSpace)テ\(wordJoiner)ク\(wordJoiner)ノ\(wordJoiner)ロ\(wordJoiner)ジ\(wordJoiner)ー\(wordJoiner)。"
        XCTAssertEqual(result, expected)
    }
}
