//
//  BudouXText.swift
//
//
//  Created by treastrain on 2022/01/16.
//

#if canImport(SwiftUI)
    import SwiftUI

    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// Creates a text view that displays a content translated by the BudouX parser given a string literal without localization.
    /// - Parameters:
    ///   - content: A string to display without localization and translate by the BudouX parser.
    ///   - parser: A BudouX parser.
    ///   - threshold: A threshold score for the BudouX parser to control the granularity of output chunks.
    ///   - condition: A condition of whether to perform translation by the BudouX parser based on the argument of the natural languages supported by the parser.
    /// - Returns: The `SwiftUI.Text` initialized from the result of translating by the BudouX parser.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public func BudouXText(
        verbatim content: String,
        parser: Parser = .init(),
        threshold: Int = Parser.defaultThreshold,
        condition: (_ naturalLanguagesSupportedByParser: Set<String>) -> Bool = defaultBudouXTextCondition
    ) -> Text {
        guard condition(parser.model.supportedNaturalLanguages) else {
            return Text(verbatim: content)
        }
        return Text(verbatim: parser.translate(sentence: content, threshold: threshold))
    }

    // swift-format-ignore: AlwaysUseLowerCamelCase
    /// Creates a text view that displays a content translated by the BudouX parser given a localized string identified by a key.
    ///
    /// Use this initializer to look for the key parameter in a localization table and translate the associated string value by BudouX parser and display it in the initialized text view.
    /// If the initializer can’t find the key in the table, or if no table exists, the text view displays the string representation of the key trasnlated by the BudouX parser instead.
    ///
    /// - Parameters:
    ///   - key: The key for a string in the table identified by `tableName`.
    ///   - tableName: The name of the string table to search. If `nil`, use the table in the `Localizable.strings` file.
    ///   - bundle: The bundle containing the strings file. If `nil`, use the main bundle.
    ///   - comment: Contextual information about this key-value pair.
    ///   - parser: A BudouX parser.
    ///   - threshold: A threshold score for the BudouX parser to control the granularity of output chunks.
    ///   - condition: A condition of whether to perform translation by the BudouX parser based on the argument of the natural languages supported by the parser.
    /// - Returns: The `SwiftUI.Text` initialized from the result of sending `localizedString(forKey:value:table:)` to bundle, passing the specified key, value, and tableName, and translating by the BudouX parser.
    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public func BudouXText(
        _ key: String,
        tableName: String? = nil,
        bundle: Bundle? = nil,
        comment: StaticString? = nil,
        parser: Parser = .init(),
        threshold: Int = Parser.defaultThreshold,
        condition: (_ naturalLanguagesSupportedByParser: Set<String>) -> Bool = defaultBudouXTextCondition
    ) -> Text {
        guard condition(parser.model.supportedNaturalLanguages) else {
            return Text(LocalizedStringKey(key), tableName: tableName, bundle: bundle, comment: comment)
        }
        let content = NSLocalizedString(key, tableName: tableName, bundle: bundle ?? .main, comment: (comment?.description ?? ""))
        return BudouXText(verbatim: content, parser: parser, threshold: threshold, condition: condition)
    }


    public let defaultBudouXTextCondition: (Set<String>) -> Bool = { naturalLanguagesSupportedByParser in
        naturalLanguagesSupportedByParser.contains(currentLocalizationKey)
    }

    private var currentLocalizationKey: String {
        NSLocalizedString("net.cyan-stivy.budoux-swift.LocalizationFinder.Key", tableName: "Localizable", bundle: .module, comment: "")
    }
#endif
