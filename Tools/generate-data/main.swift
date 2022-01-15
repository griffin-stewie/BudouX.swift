//
//  main.swift
//
//
//  Created by griffin-stewie on 2021/12/21.
//
//

import ArgumentParser
import Foundation

// MARK: Helpers

extension Foundation.URL: ExpressibleByArgument {
    public init?(argument: String) {
        self.init(string: argument)
    }
}

extension String {
    func escapingUnicode() -> String {
        replacingOccurrences(
            of: #"\\u(\S{4})"#,
            with: #"\\u{$1}"#,
            options: .regularExpression,
            range: range(of: self))
    }
}

// MARK: Command

struct GenerateData: ParsableCommand {
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            abstract: "A helper tool for generating data that BudouX needs."
        )
    }

    enum CodingKeys: String, CodingKey {
        case repositoryRootDirectory
    }

    let unicodeBlocksJSONURL: URL = URL(string: "https://raw.githubusercontent.com/google/budoux/main/budoux/unicode_blocks.json")!
    let jaKNBCJSONURL: URL = URL(string: "https://raw.githubusercontent.com/google/budoux/main/budoux/models/ja-knbc.json")!

    @Option(name: [.short, .customLong("repo-root")], help: "The GitHub repository to search for changes.")
    var repositoryRootDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    func generateUnicodeBlocksCode(data: Data) -> String {
        """
        // swift-format-ignore-file
        extension Model {
            static let unicodeBlocks = \(String(data: data, encoding: .utf8)!)
        }
        """
    }

    func generateJaKNBCCode(data: Data) -> String {
        let jsonStr = String(data: data, encoding: .utf8)!
            .replacingOccurrences(of: "{", with: "[")
            .replacingOccurrences(of: "}", with: "]")
            .escapingUnicode()
        return """
            // swift-format-ignore-file
            extension Model {
                /// Default jaKNBC Model.
                public static let jaKNBCModel: [String: Int] = \(jsonStr)
            }
            """
    }

    mutating func run() throws {
        let unicodeBlocksJSONData = try Data(contentsOf: unicodeBlocksJSONURL)
        let unicodeBlocksSwiftPath = repositoryRootDirectory.appendingPathComponent("Sources/BudouX/Data/UnicodeBlocks.swift")
        try generateUnicodeBlocksCode(data: unicodeBlocksJSONData)
            .write(toFile: unicodeBlocksSwiftPath.path, atomically: true, encoding: .utf8)

        let jaKNBCJSONData = try Data(contentsOf: jaKNBCJSONURL)
        let jaKNBCSwiftPath = repositoryRootDirectory.appendingPathComponent("Sources/BudouX/Data/JaKNBCModel.swift")
        try generateJaKNBCCode(data: jaKNBCJSONData)
            .write(toFile: jaKNBCSwiftPath.path, atomically: true, encoding: .utf8)
    }
}

GenerateData.main()
