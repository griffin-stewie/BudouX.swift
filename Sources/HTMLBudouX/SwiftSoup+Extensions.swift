//
//  SwiftSoup+Extensions.swift
//  
//
//  Created by griffin-stewie on 2021/12/24.
//  
//

import Foundation
import SwiftSoup

extension SwiftSoup.Element {
    @discardableResult
    func addAttr(_ attributeKey: String, _ attributeValue: String) throws -> Element {
        let separator = ";"
        let atv = attributeValue.hasSuffix(separator) ? attributeValue : attributeValue + separator
        let value = try attr(attributeKey)

        let joined: String
        if value.isEmpty {
            joined = atv
        } else if value.hasSuffix(separator) {
            joined = "\(value) \(atv)"
        } else {
            joined = "\(value + separator) \(atv)"
        }

        return try attr(attributeKey, joined)
    }
}

extension SwiftSoup.Node {
    func textContent() -> String {
        let accum: StringBuilder = StringBuilder()
        _ = try? traverse(TextContentVisitor(accum))
        return accum.toString().trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func replaceWith(nodes: [Node]) {
        var nodesToAdd = nodes
        guard !nodesToAdd.isEmpty else {
            return
        }

        var node = nodesToAdd.removeFirst()
        try! self.replaceWith(node)

        for n in nodesToAdd {
            try! node.after(n)
            node = n
        }
    }
}

fileprivate extension SwiftSoup.Node {
    class TextContentVisitor: NodeVisitor {
        let accum: StringBuilder

        init(_ accum: StringBuilder) {
            self.accum = accum
        }

        public func head(_ node: Node, _ depth: Int) {
            if let textNode = (node as? TextNode) {
                Element.appendNormalisedText(accum, textNode)
            } else if let element = (node as? Element) {
                if (accum.length > 0 &&
                    (element.isBlock() || element.tag().getName() == "br") &&
                    !TextNode.lastCharIsWhitespace(accum)) {
                    if let txt = try? element.html() {
                        accum.append(txt)
                    }
                }
            }
        }

        public func tail(_ node: Node, _ depth: Int) { }
    }

    // Copied from SwiftSoup internal implementation
    private static func appendNormalisedText(_ accum: StringBuilder, _ textNode: TextNode) {
        let text: String = textNode.getWholeText()

        if (Element.preserveWhitespace(textNode.parent())) {
            accum.append(text)
        } else {
            StringUtil.appendNormalisedWhitespace(accum, string: text, stripLeading: TextNode.lastCharIsWhitespace(accum))
        }
    }

    // Copied from SwiftSoup internal implementation
    static func preserveWhitespace(_ node: Node?) -> Bool {
        if let element = (node as? Element) {
            return element.tag().preserveWhitespace() || element.parent() != nil && element.parent()!.tag().preserveWhitespace()
        }
        return false
    }
}
