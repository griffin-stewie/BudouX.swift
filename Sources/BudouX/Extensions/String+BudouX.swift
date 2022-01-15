//
//  String+BudouX.swift
//
//
//  Created by griffin-stewie on 2021/12/20.
//
//

import Foundation

extension String {
    /// Translates the given `String` to another `String` with word joiners and zero width spaces for semantic line breaks.
    /// - Parameter parser: Use default Japanese model as default.
    /// - Returns: The translated `String`.
    public func budouxed(_ parser: Parser = .init()) -> String {
        parser.translate(sentence: self)
    }
}

extension String {
    /// Remove \u{2060} Word Joiner and \u{200B} Zero Width Space
    /// - Returns: String special characters are removed
    public func washout() -> String {
        replacingOccurrences(of: Parser.wordJoiner, with: "").replacingOccurrences(of: Parser.zeroWidthSpace, with: "")
    }
}
