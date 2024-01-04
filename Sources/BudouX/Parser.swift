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

    /// Parses the input sentence and returns a list of semantic chunks.
    /// - Parameters:
    ///   - sentence: sentence An input sentence.
    /// - Returns: The retrieved chunks.
    public func parse(sentence: String) -> [String] {
        guard !sentence.isEmpty else {
            return []
        }

        let boundaries = parseBoundaries(sentence: sentence)
        var result: [String] = [];
        var start: String.UnicodeScalarView.Index = sentence.unicodeScalars.startIndex;
        for boundary in boundaries {
            result.append(String(sentence.unicodeScalars[start..<boundary]))
            start = boundary
        }
        result.append(String(sentence.unicodeScalars[start...]))
        return result;
    }

    private func parseBoundaries(sentence: String) -> [String.UnicodeScalarView.Index] {
        var result: [String.UnicodeScalarView.Index] = []
        let baseScore: Double = {
            Double(model.values.map(\.arrayOfValue).flatMap({ $0 }).sum()) * -0.5
        }()

        for i in 1..<sentence.unicodeScalars.count {
            var score = baseScore
            score += model.score(for: "UW1", at: sentence.unicodeScalars.slice(i-3, i-2))
            score += model.score(for: "UW2", at: sentence.unicodeScalars.slice(i-2, i-1))
            score += model.score(for: "UW3", at: sentence.unicodeScalars.slice(i-1, i))
            score += model.score(for: "UW4", at: sentence.unicodeScalars.slice(i, i+1))
            score += model.score(for: "UW5", at: sentence.unicodeScalars.slice(i+1, i+2))
            score += model.score(for: "UW6", at: sentence.unicodeScalars.slice(i+2, i+3))
            score += model.score(for: "BW1", at: sentence.unicodeScalars.slice(i-2, i))
            score += model.score(for: "BW2", at: sentence.unicodeScalars.slice(i-1, i+1))
            score += model.score(for: "BW3", at: sentence.unicodeScalars.slice(i, i+2))
            score += model.score(for: "TW1", at: sentence.unicodeScalars.slice(i-3, i))
            score += model.score(for: "TW2", at: sentence.unicodeScalars.slice(i-2, i+1))
            score += model.score(for: "TW3", at: sentence.unicodeScalars.slice(i-1, i+2))
            score += model.score(for: "TW4", at: sentence.unicodeScalars.slice(i, i+3))

            if score > 0, let index = sentence.unicodeScalars.index(of: i) {
                result.append(index)
            }
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

extension Model {
    var values: [[String: Int]] {
        featureAndScore.arrayOfValue
    }

    func score(for rootKey: String, at key: String?) -> Double {
        guard let dict: [String: Int] = featureAndScore[rootKey] else {
            return 0
        }

        guard let key else {
            return 0
        }

        guard let value = dict[key] else {
            return 0
        }

        return Double(value)
    }
}

extension Dictionary {
    var arrayOfValue: [Dictionary.Value] {
        values.map { $0 }
    }
}
