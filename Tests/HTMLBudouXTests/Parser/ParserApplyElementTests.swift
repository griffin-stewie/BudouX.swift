import XCTest
import BudouX
import SwiftSoup
@testable import HTMLBudouX

final class ParserApplyElementTests: XCTestCase {

    private func checkEqual(model: [String: Int], inputHTML: String, expectedHTML: String) {
        let doc = try! SwiftSoup.parse(inputHTML)
        let inputElement = try! doc.select("p").first()!
        let parser = BudouX.Parser(model: model)
        parser.applyElement(parentElement: inputElement)

        let expectedElement = try! SwiftSoup.parse(expectedHTML).select("p").first()!
        XCTAssertEqual(inputElement.description, expectedElement.description)
    }

    func testHasChildTextNode() throws {
        let inputHTML = "<p>xyzabcabc</p>"
        let doc = try SwiftSoup.parse(inputHTML)
        let element = try doc.select("p").first()!
        let result = Parser.hasChildTextNode(element)
        XCTAssertTrue(result)
    }

    func testShouldInsertWBRTagsWhereTheSentenceShouldBreak() throws {
        let inputHTML = "<p>xyzabcabc</p>"
        let expectedHTML = """
        <p style="word-break: keep-all; overflow-wrap: break-word;"
        >xyz<wbr>abc<wbr>abc</p>
        """

        let model: [String: Int] = [
            "UW4:a": 1001, // means "should separate right before 'a'".
        ]
        checkEqual(model: model, inputHTML: inputHTML, expectedHTML: expectedHTML);
    }

    func testShouldInsertWBRTagsEvenItOverlapsWithOtherHTMLTags() throws {
        let inputHTML = """
        <p>xy<a href="#">zabca</a>bc</p>
        """

        let expectedHTML = """
        <p style="word-break: keep-all; overflow-wrap: break-word;"
        >xy<a href="#">z<wbr>abc<wbr>a</a>bc</p>
        """

        let model: [String: Int] = [
            "UW4:a": 1001, // means "should separate right before 'a'".
        ]
        checkEqual(model: model, inputHTML: inputHTML, expectedHTML: expectedHTML);
    }
}
