//
//  Parser.swift
//  
//
//  Created by griffin-stewie on 2021/12/16.
//  
//

import Foundation

public struct Parser {
    let model: [String: Int]

    public init(model: [String : Int]) {
        self.model = model
    }

    /// Generates a Unicode Block feature from the given character.
    /// - Parameter w: A character input.
    /// - Returns: A Unicode Block feature.
    static func getUnicodeBlockFeature(_ w: String) -> String {
        let bn: Int
        if w.isEmpty {
            bn = 999
        } else {
            let cp = w.utf16[w.utf16.startIndex]
            bn = bisectRight(arr: unicodeBlocks, i: Int(cp))
        }

        return String(format: "%03d", bn)
    }
}
