//
//  main.swift
//
//
//  Created by griffin-stewie on 2021/12/17.
//
//

import ArgumentParser
import BudouX
import Foundation
import Path

struct MainCommandOptions: ParsableArguments {
    @Flag(name: [.customLong("swift-string"), .customShort("s")], help: ArgumentHelp("Swift String mode"))
    var swiftStringMode: Bool = false

    @Option(name: [.customLong("delim"), .customShort("d")], help: ArgumentHelp("output delimiter in TEXT mode"))
    var delimiter = "---"

    @Option(name: [.customLong("model"), .customShort("m")], help: ArgumentHelp("custom model file path (default: built-in ja-knbc.json)"))
    var customModelJSONPath: Path?

    @Option(name: [.customLong("language"), .customShort("l")], parsing: .singleValue, help: ArgumentHelp("natural language (following the IETF format) that the custom model file supports. (example: ja)"))
    var supportedNaturalLanguages: [String] = []

    @Argument(help: ArgumentHelp("text", valueName: "TXT"))
    var argument: String?
}


struct MainCommand: ParsableCommand {

    enum CommandError: Error, CustomStringConvertible {
        case noInput

        var description: String {
            switch self {
            case .noInput:
                return "no input"
            }
        }
    }

    static var configuration = CommandConfiguration(
        commandName: "budoux-swift",
        abstract: "budoux-swift is BudouX swift port. BudouX is the successor to Budou, the machine learning powered line break organizer tool.",
        version: "0.5.0"
    )

    @OptionGroup()
    var options: MainCommandOptions

    func run() throws {
        let input: String
        if let arg = options.argument {
            input = arg
        } else {
            guard let read = readSTDIN() else {
                throw CommandError.noInput
            }
            input = read
        }

        let model: Model = try loadCustomModel(from: options.customModelJSONPath, supportedNaturalLanguages: Set(options.supportedNaturalLanguages)) ?? JaKNBCModel()
        let parser = Parser(model: model)
        let splitedTextsByNewline = input.components(separatedBy: .newlines).filter({ !$0.isEmpty })

        if options.swiftStringMode {
            for text in splitedTextsByNewline {
                print(parser.translate(sentence: text))
            }
        } else {
            for (i, text) in splitedTextsByNewline.enumerated() {
                let results = parser.parse(sentence: text)
                for t in results {
                    print(t)
                }
                if i + 1 != splitedTextsByNewline.endIndex {
                    print(options.delimiter)
                }
            }
        }
    }

    private func readSTDIN() -> String? {
        var inputs: [String] = []
        while let line = readLine() {
            inputs.append(line)
        }

        guard !inputs.isEmpty else {
            return nil
        }

        return inputs.joined(separator: "\n")
    }

    private func loadCustomModel(from path: Path?, supportedNaturalLanguages: Set<String>) throws -> CustomModel? {
        guard let path = path else {
            return nil
        }

        guard let featureAndScore = try JSONSerialization.jsonObject(with: try Data(contentsOf: path), options: []) as? [String: Int] else {
            return nil
        }

        return CustomModel(supportedNaturalLanguages: supportedNaturalLanguages, featureAndScore: featureAndScore)
    }


}

extension Path: ExpressibleByArgument {

    /// Initializer to confirm `ExpressibleByArgument`
    public init?(argument: String) {
        self = Path(argument) ?? Path.cwd / argument
    }

    /// `defaultValueDescription` to confirm `ExpressibleByArgument`
    public var defaultValueDescription: String {
        if self == Path.cwd / "." {
            return "current directory"
        }

        return String(describing: self)
    }
}

MainCommand.main()
