//
//  Parser.swift
//
//
//  Created by griffin-stewie on 2021/12/16.
//
//

import Foundation

extension Parser {
    /// A character to connect characters so that they are not easily broken into new lines.
    public static let wordJoiner: String = "\u{2060}"

    /// A character to represent a space between characters that may be broken.
    public static let zeroWidthSpace: String = "\u{200B}"
}

/// The main parser object with a variety of class methods to provide semantic
/// chunks and markups from the given input string.
public struct Parser {
    let model: Model

    /// Initializer.
    /// - Parameter model: A model mapping a feature (str) and its score (int). Default is built-in JaKNBCModel.
    public init(model: Model = JaKNBCModel()) {
        self.model = model
    }

    /// Generates a feature from characters around (w1-w6).
    /// - Parameters:
    ///   - w1: The character 3 characters before the break point.
    ///   - w2: The character 2 characters before the break point.
    ///   - w3: he character right before the break point.
    ///   - w4: The character right after the break point.
    ///   - w5: The character 2 characters after the break point.
    ///   - w6: The character 3 characters after the break point.
    /// - Returns: A feature to be consumed by a classifier.
    static func getFeature(
        w1: String,
        w2: String,
        w3: String,
        w4: String,
        w5: String,
        w6: String
    ) -> [String] {
        let rawFeature = [
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
        ]
        return
            rawFeature
            .filter { (_, value) -> Bool in !value.contains(invalid) }
            .map { (key, value) -> String in "\(key):\(value)" }
    }

    static func getFeature(
        w1: Character,
        w2: Character,
        w3: Character,
        w4: Character,
        w5: Character,
        w6: Character
    ) -> [String] {
        return getFeature(w1: String(w1), w2: String(w2), w3: String(w3), w4: String(w4), w5: String(w5), w6: String(w6))
    }

    /// Parses the input sentence and returns a list of semantic chunks.
    /// - Parameters:
    ///   - sentence: sentence An input sentence.
    /// - Returns: The retrieved chunks.
    public func parse(sentence: String) -> [String] {
        guard !sentence.isEmpty else {
            return []
        }

        var result = [String(sentence[sentence.startIndex])]
        let baseScore = -(model.values.sum())

        for i in 1..<sentence.count {
            let feature = Parser.getFeature(
                w1: sentence.string(at: i - 3) ?? invalid,
                w2: sentence.string(at: i - 2) ?? invalid,
                w3: sentence.string(at: i - 1)!,
                w4: sentence.string(at: i)!,
                w5: sentence.string(at: i + 1) ?? invalid,
                w6: sentence.string(at: i + 2) ?? invalid
            )

            let score =
                baseScore + 2
                * feature
                .map { model.featureAndScore[$0] ?? 0 }
                .sum()
            if score > 0 {
                result.append("")
            }

            result[result.count - 1] += sentence.string(at: i)!
        }

        return result
    }
}

// MARK: - Translates to `String`

extension Parser {

    /// Translates the given `String` to another `String` with word joiners and zero width spaces for semantic line breaks.
    /// - Parameters:
    ///   - sentence: An input sentence.
    /// - Returns: The translated `String`.
    public func translate(sentence: String) -> String {
        let chunks = parse(sentence: sentence)
        return insertSpaces(chunks)
    }

    func insertSpaces(_ chunks: [String]) -> String {
        return
            chunks
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
        guard index >= 0 else {
            return nil
        }
        guard index < count else {
            return nil
        }
        guard let strIndex = self.index(startIndex, offsetBy: index, limitedBy: endIndex) else {
            return nil
        }
        return String(self[strIndex])
    }
}

extension Model {
    var values: [Int] {
        featureAndScore.values.map { $0 }
    }
}
