//
//  String+BudouX.swift
//  
//
//  Created by griffin-stewie on 2021/12/20.
//  
//

import Foundation

public extension String {
    /// Translates the given `String` to another `String` with word joiners and zero width spaces for semantic line breaks.
    /// - Parameter parser: Use default Japanese model as default.
    /// - Returns: The translated `String`.
    func budouxed(_ parser: Parser = .init()) -> String {
        parser.translate(sentence: self)
    }
}

public extension String {
    /// Remove \u{2060} Word Joiner and \u{200B} Zero Width Space
    /// - Returns: String special characters are removed
    func washout() -> String {
        replacingOccurrences(of: BudouX.wordJoiner, with: "").replacingOccurrences(of: BudouX.zeroWidthSpace, with: "")
    }
}
