//
//  File.swift
//  
//
//  Created by griffin-stewie on 2021/12/22.
//  
//

import Foundation
import BudouX
import SwiftSoup

// MARK: - Translates to `HTML`

public extension BudouX.Parser {
    func translateHTMLString(html: String, threshold: Int = Parser.defaultThres) -> String {
        guard !html.isEmpty else {
            return html
        }

        guard let doc = try? SwiftSoup.parse(html) else {
            return html
        }

        if let body = doc.body(), Parser.hasChildTextNode(body) {
            let wrapper = try! doc.createElement("span")
            let children = doc.body()!.getChildNodes()
            for c in children {
                try! wrapper.appendChild(c)
            }
            try! doc.body()!.appendChild(wrapper)
        }
        applyElement(parentElement: doc.body()!.childNode(0) as! Element, threshold: threshold)
        return try! doc.body()!.html()
    }
}

extension BudouX.Parser {
    func applyElement(parentElement: Element, threshold: Int = Parser.defaultThres) {
        try! parentElement.addAttr("style", "word-break: keep-all")
        try! parentElement.addAttr("style", "overflow-wrap: break-word")

        let chunks = self.parse(sentence: parentElement.textContent(), thres: threshold)
        var charsToProcess = chunks.joined(separator: SEP)
        let ownerDocument = parentElement.ownerDocument()!

        func processChildren(parent: Element) {

            let toSkip = skipNodes.contains(parent.nodeName().uppercased())

            func process(child: Node, content: String) {
                var textNodeContent = ""
                var nodesToAdd: [Node] = []

                content.forEach { char in
                    if toSkip {
                        textNodeContent += String(char)
                        charsToProcess = String(charsToProcess.dropFirst( String(charsToProcess.first!) == SEP ? 2 : 1 ))
                    } else if char == charsToProcess.first! {
                        textNodeContent += String(char)
                        charsToProcess = String(charsToProcess.dropFirst(1))
                    } else if String(charsToProcess.first!) == SEP {
                        nodesToAdd.append(TextNode(textNodeContent, ownerDocument.getBaseUri()))
                        nodesToAdd.append(try! ownerDocument.createElement("wbr"))
                        charsToProcess = String(charsToProcess.dropFirst(2))
                        textNodeContent = String(char)
                    }
                }

                if !textNodeContent.isEmpty {
                    nodesToAdd.append(TextNode(textNodeContent, ownerDocument.getBaseUri()))
                }

                child.replaceWith(nodes: nodesToAdd)
            }

            for child in parent.getChildNodes() {
                switch child {
                case let dataNode as DataNode:
                    process(child: child, content: dataNode.getWholeData())
                case let textNode as TextNode:
                    process(child: child, content: textNode.textContent())
                case let element as Element:
                    processChildren(parent: element);
                default:
                    break
                }
            }
        }

        processChildren(parent: parentElement)
    }

    static func hasChildTextNode(_ element: Element) -> Bool {
        !element.textNodes().isEmpty
    }
}

/** The separator string to specify breakpoints. */
let SEP = "_"

let skipNodes: Set<String> = [
  "ABBR",
  "BUTTON",
  "CODE",
  "IFRAME",
  "INPUT",
  "META",
  "SCRIPT",
  "STYLE",
  "TEXTAREA",
  "TIME",
  "VAR"
]
