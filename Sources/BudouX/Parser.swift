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

    /// Generates a feature from characters around (w1-w6) and past results (p1-p3).
    /// - Parameters:
    ///   - w1: The character 3 characters before the break point.
    ///   - w2: The character 2 characters before the break point.
    ///   - w3: he character right before the break point.
    ///   - w4: The character right after the break point.
    ///   - w5: The character 2 characters after the break point.
    ///   - w6: The character 3 characters after the break point.
    ///   - p1: The result 3 steps ago.
    ///   - p2: The result 2 steps ago.
    ///   - p3: The last result.
    /// - Returns: A feature to be consumed by a classifier.
    static func getFeature(w1: String,
                           w2: String,
                           w3: String,
                           w4: String,
                           w5: String,
                           w6: String,
                           p1: String,
                           p2: String,
                           p3: String) -> [String] {
        let b1 = Parser.getUnicodeBlockFeature(w1)
        let b2 = Parser.getUnicodeBlockFeature(w2)
        let b3 = Parser.getUnicodeBlockFeature(w3)
        let b4 = Parser.getUnicodeBlockFeature(w4)
        let b5 = Parser.getUnicodeBlockFeature(w5)
        let b6 = Parser.getUnicodeBlockFeature(w6)
        let rawFeature = [
          "UP1": p1,
          "UP2": p2,
          "UP3": p3,
          "BP1": p1 + p2,
          "BP2": p2 + p3,
          "UW1": w1,
          "UW2": w2,
          "UW3": w3,
          "UW4": w4,
          "UW5": w5,
          "UW6": w6,
          "BW1": w2 + w3,
          "BW2": w3 + w4,
          "BW3": w4 + w5,
          "TW1": w1 + w2 + w3,
          "TW2": w2 + w3 + w4,
          "TW3": w3 + w4 + w5,
          "TW4": w4 + w5 + w6,
          "UB1": b1,
          "UB2": b2,
          "UB3": b3,
          "UB4": b4,
          "UB5": b5,
          "UB6": b6,
          "BB1": b2 + b3,
          "BB2": b3 + b4,
          "BB3": b4 + b5,
          "TB1": b1 + b2 + b3,
          "TB2": b2 + b3 + b4,
          "TB3": b3 + b4 + b5,
          "TB4": b4 + b5 + b6,
          "UQ1": p1 + b1,
          "UQ2": p2 + b2,
          "UQ3": p3 + b3,
          "BQ1": p2 + b2 + b3,
          "BQ2": p2 + b3 + b4,
          "BQ3": p3 + b2 + b3,
          "BQ4": p3 + b3 + b4,
          "TQ1": p2 + b1 + b2 + b3,
          "TQ2": p2 + b2 + b3 + b4,
          "TQ3": p3 + b1 + b2 + b3,
          "TQ4": p3 + b2 + b3 + b4,
        ]
        return rawFeature.map { (key, value) -> String in "\(key):\(value)" }
    }
}
