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

extension BudouX.Parser {
    func applyElement(parentElement: Element, threshold: Int = Parser.defaultThres) {
        try! parentElement.attr("style", "word-break: keep-all; overflow-wrap: break-word;")
        let chunks = self.parse(sentence: try! parentElement.text(), thres: threshold)
        print(chunks)
        var charsToProcess = chunks.joined(separator: SEP)
        print(charsToProcess)

        let ownerDocument = parentElement.ownerDocument()!

        func processChildren(parent: Element) {
            let toSkip = skipNodes.contains(parent.nodeName().uppercased())
            for child in parent.getChildNodes() {
                switch child {
                case let textNode as TextNode:
                    print(textNode)

                    var textNodeContent = ""
                    var nodesToAdd: [Node] = []

                    textNode.text().forEach { char in
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

                    if let parent = child.parent() {
                        try! child.replaceWith(nodesToAdd.removeFirst())
                        try! parent.addChildren(nodesToAdd)
                    }

                case let element as Element:
                    processChildren(parent: element);
                default:
                    fatalError()
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
