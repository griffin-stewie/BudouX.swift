import XCTest
import BudouX
import SwiftSoup
@testable import HTMLBudouX

final class ParserTranslateHTMLStringTests: XCTestCase {

    let defaultModel: [String: Int] = [
        "UW4:a": 1001 // means "should separate right before 'a'".
    ]

    private func checkEqual(model: [String: Int], inputHTML: String, expectedHTML: String) {
        let parser = BudouX.Parser(model: model)
        let result = parser.translateHTMLString(html: inputHTML)
        let resultDOM = try! SwiftSoup.parse(result)
        let expectedDOM = try! SwiftSoup.parse(expectedHTML)

        XCTAssertEqual(resultDOM.ownerDocument()!.description, expectedDOM.ownerDocument()!.description)
    }

    func testShouldOutputAHtmlStringWithASpanParentWithProperStyleAttributes() throws {
        let inputHTML = "xyzabcd"
        let expectedHTML = """
        <span style="word-break: keep-all; overflow-wrap: break-word;">xyz<wbr>abcd</span>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testShouldNotAddASpanParentIfTheInputAlreadyHasOneSingleParent() throws {
        let inputHTML = """
        <p class="foo" style="color: red">xyzabcd</p>
        """
        let expectedHTML = """
        <p class="foo"
           style="color: red; word-break: keep-all; overflow-wrap: break-word;"
        >xyz<wbr>abcd</p>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testShouldReturnABlankStringIfTheInputIsBlank() throws {
        let inputHTML = ""
        let expectedHTML = ""
        let model: [String: Int] = [:]
        checkEqual(model: model, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testShouldPassScriptTagsAsIs() throws {
        let inputHTML = """
        xyz<script>alert(1);</script>xyzabc
        """
        let expectedHTML = """
        <span
        style="word-break: keep-all; overflow-wrap: break-word;"
        >xyz<script>alert(1);</script>xyz<wbr>abc</span>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testScriptTagsOnTopShouldBeDiscardedByTheDomparser() throws {
        let inputHTML = """
        <script>alert(1);</script>xyzabc
        """
        let expectedHTML = """
        <span
        style="word-break: keep-all; overflow-wrap: break-word;"
        >xyz<wbr>abc</span>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testShouldSkipSomeSpecificTags() throws {
        let inputHTML = """
        xyz<code>abc</code>abc
        """
        let expectedHTML = """
        <span
        style="word-break: keep-all; overflow-wrap: break-word;"
        >xyz<code>abc</code><wbr>abc</span>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testShouldNotRuinAttributesOfChildElements() throws {
        let inputHTML = """
        xyza<a href="#" hidden>bc</a>abc
        """
        let expectedHTML = """
        <span
        style="word-break: keep-all; overflow-wrap: break-word;"
        >xyz<wbr>a<a href="#" hidden>bc</a><wbr>abc</span>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }

    func testShouldWorkWithEmojis() throws {
        let inputHTML = """
        xyza🇯🇵🇵🇹abc
        """
        let expectedHTML = """
        <span
        style="word-break: keep-all; overflow-wrap: break-word;"
        >xyz<wbr>a🇯🇵🇵🇹<wbr>abc</span>
        """
        checkEqual(model: defaultModel, inputHTML: inputHTML, expectedHTML: expectedHTML)
    }
}
