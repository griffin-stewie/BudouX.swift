//
//  main.swift
//  
//
//  Created by griffin-stewie on 2021/12/17.
//  
//

import BudouX
import ArgumentParser
import Path
import Foundation

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
        version: "1.0.0"
    )

    @Flag(name: [.customLong("swift-string"), .customShort("s")], help: ArgumentHelp("Swift String mode"))
    var swiftStringMode: Bool = false

    @Option(name: [.customLong("delim"), .customShort("d")], help: ArgumentHelp("output delimiter in TEXT mode"))
    var delimiter = "---"

    @Option(name: [.customLong("thres"), .customShort("t")], help: ArgumentHelp("threshold value to separate chunk"))
    var threshold: Int = Parser.defaultThreshold

    @Option(name: [.customLong("model"), .customShort("m")], help: ArgumentHelp("custom model file path (default: built-in ja-knbc.json)"))
    var customModelJSONPath: Path?

    @Argument(help: ArgumentHelp("text", valueName: "TXT"))
    var argument: String?

    func run() throws {
        let input: String
        if let arg = argument {
            input = arg
        } else {
            guard let read = readSTDIN() else {
                throw CommandError.noInput
            }
            input = read
        }

        let model = try loadCustomModelJSON(from: customModelJSONPath) ?? Model.jaKNBCModel
        let parser = Parser(model: model)
        let splitedTextsByNewline = input.components(separatedBy: .newlines).filter({ !$0.isEmpty })

        if swiftStringMode {
            for text in splitedTextsByNewline {
                print(parser.translate(sentence: text, threshold: threshold))
            }
        } else {
            for (i, text) in splitedTextsByNewline.enumerated() {
                let results = parser.parse(sentence: text, threshold: threshold)
                for t in results {
                    print(t)
                }
                if i + 1 != splitedTextsByNewline.endIndex {
                    print(delimiter)
                }
            }
        }
    }

    private func readSTDIN () -> String? {
        var inputs: [String] = []
        while let line = readLine() {
            inputs.append(line)
        }

        guard !inputs.isEmpty else {
            return nil
        }

        return inputs.joined(separator: "\n")
    }

    private func loadCustomModelJSON(from path: Path?) throws -> [String: Int]? {
        guard let path = path else {
            return nil
        }

        guard let model = try JSONSerialization.jsonObject(with: try Data(contentsOf: path), options: []) as? [String: Int] else {
            return nil
        }

        return model
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
