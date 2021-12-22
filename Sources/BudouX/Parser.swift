//
//  Parser.swift
//  
//
//  Created by griffin-stewie on 2021/12/16.
//  
//

import Foundation

extension Parser {
    /// The default threshold value for the parser.
    public static let defaultThres = 1000;

    public static let wordJoiner: String = "\u{2060}"
    public static let zeroWidthSpace: String = "\u{200B}"
}


public struct Parser {
    let model: [String: Int]

    public init(model: [String : Int] = Model.jaKNBCModel) {
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
            bn = bisectRight(arr: Model.unicodeBlocks, i: Int(cp))
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

    static func getFeature(w1: Character,
                           w2: Character,
                           w3: Character,
                           w4: Character,
                           w5: Character,
                           w6: Character,
                           p1: Character,
                           p2: Character,
                           p3: Character) -> [String] {
        return getFeature(w1: String(w1), w2: String(w2), w3: String(w3), w4: String(w4), w5: String(w5), w6: String(w6), p1: String(p1), p2: String(p2), p3: String(p3))
    }

    /// Parses the input sentence and returns a list of semantic chunks.
    /// - Parameters:
    ///   - sentence: sentence An input sentence.
    ///   - thres: thres A threshold score to control the granularity of output chunks.
    /// - Returns: The retrieved chunks.
    public func parse(sentence: String, thres: Int = Parser.defaultThres) -> [String] {
        guard !sentence.isEmpty else {
            return []
        }

        var p1 = "U"
        var p2 = "U"
        var p3 = "U"

        let index = sentence.index(sentence.startIndex, offsetBy: 3)
        var result = [String(sentence.prefix(upTo: index))];

        for i in 3..<sentence.count {
            let feature = Parser.getFeature(w1: sentence.string(at: i - 3)!,
                                            w2: sentence.string(at: i - 2)!,
                                            w3: sentence.string(at: i - 1)!,
                                            w4: sentence.string(at: i)!,
                                            w5: sentence.string(at: i + 1) ?? "",
                                            w6: sentence.string(at: i + 2) ?? "",
                                            p1: p1,
                                            p2: p2,
                                            p3: p3)

            let score = feature
                .map { model[$0] ?? 0 }
                .reduce(0, +)
            let p = score > 0 ? "B" : "O"
            if score > thres {
                result.append("")
            }

            result[result.count - 1] += sentence.string(at: i)!
            p1 = p2
            p2 = p3
            p3 = p
        }

        return result
    }
}

// MARK: - Translates to `String`

extension Parser {

    /// Translates the given `String` to another `String` with word joiners and zero width spaces for semantic line breaks.
    /// - Parameters:
    ///   - sentence: An input sentence.
    ///   - thres: A threshold score to control the granularity of output chunks.
    /// - Returns: The translated `String`.
    public func translate(sentence: String, thres: Int = Parser.defaultThres) -> String {
        let chunks = parse(sentence: sentence, thres: thres)
        return insertSpaces(chunks)
    }

    func insertSpaces(_ chunks: [String]) -> String {
        return chunks
            .map { insertWordJoinerBetweenEachCharacter($0) }
            .joined(separator: Parser.zeroWidthSpace)
    }

    func insertWordJoinerBetweenEachCharacter(_ text: String) -> String {
        text
            .map { String($0) }
            .joined(separator: Parser.wordJoiner)
    }
}

// MARK: - Internal

extension String {
    func string(at index: Int) -> String? {
        guard index < count else {
            return nil
        }
        guard let strIndex = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else {
            return nil
        }
        return String(self[strIndex])
    }
}
