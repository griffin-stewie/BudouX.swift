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
        case commit
        case repositoryRootDirectory
        case subDirectory
    }

    var jaKNBCJSONURL: URL { URL(string: "https://raw.githubusercontent.com/google/budoux/\(commit)/budoux/models/ja.json")! }

    var zhHansJSONURL: URL { URL(string: "https://raw.githubusercontent.com/google/budoux/\(commit)/budoux/models/zh-hans.json")! }
    var zhHantJSONURL: URL { URL(string: "https://raw.githubusercontent.com/google/budoux/\(commit)/budoux/models/zh-hant.json")! }
    var thJSONURL: URL { URL(string: "https://raw.githubusercontent.com/google/budoux/\(commit)/budoux/models/th.json")! }

    @Option(name: .shortAndLong, help: "The commit hash of model data.")
    var commit: String = "main"

    @Option(name: [.short, .customLong("repo-root")], help: "a repository root directory to export sorce files")
    var repositoryRootDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

    @Option(name: [.short, .customLong("sub-dir")], help: "sub directory path from 'repo-root'")
    var subDirectory: String = "Sources/BudouX/Data/"

    func generateJaKNBCCode(data: Data) -> String {
        let jsonStr = String(data: data, encoding: .utf8)!
            .replacingOccurrences(of: "{", with: "[")
            .replacingOccurrences(of: "}", with: "]")
            .escapingUnicode()
        return """
            // swift-format-ignore-file
            public struct JaKNBCModel: Model {
                public init() {}
                public let supportedNaturalLanguages: Set = ["ja"]
                /// Default built-in model mapping a feature (str) and its score (int).
                public let featureAndScore: [String: [String: Int]] = \(jsonStr)
            }
            """
    }

    func generateZhHansModelCode(data: Data) -> String {
        let jsonStr = String(data: data, encoding: .utf8)!
            .replacingOccurrences(of: "{", with: "[")
            .replacingOccurrences(of: "}", with: "]")
            .escapingUnicode()
        return """
            // swift-format-ignore-file
            public struct ZhHansModel: Model {
                public init() {}
                public let supportedNaturalLanguages: Set = ["zh-Hans"]
                /// Default built-in model mapping a feature (str) and its score (int).
                public let featureAndScore: [String: [String: Int]] = \(jsonStr)
            }
            """
    }

    func generateZhHantModelCode(data: Data) -> String {
        let jsonStr = String(data: data, encoding: .utf8)!
            .replacingOccurrences(of: "{", with: "[")
            .replacingOccurrences(of: "}", with: "]")
            .escapingUnicode()
        return """
            // swift-format-ignore-file
            public struct ZhHantModel: Model {
                public init() {}
                public let supportedNaturalLanguages: Set = ["zh-Hant"]
                /// Default built-in model mapping a feature (str) and its score (int).
                public let featureAndScore: [String: [String: Int]] = \(jsonStr)
            }
            """
    }

    func generateThModelCode(data: Data) -> String {
        let source = String(data: data, encoding: .utf8)!
        let jsonStr = source
            .replacingOccurrences(of: "{", with: "[")
            .replacingOccurrences(of: "}", with: "]")
            .escapingUnicode()
        return """
            // swift-format-ignore-file
            public struct ThModel: Model {
                public init() {}
                public let supportedNaturalLanguages: Set = ["th"]
                /// Default built-in model mapping a feature (str) and its score (int).
                public let featureAndScore: [String: [String: Int]] = \(jsonStr)
            }
            """
    }

    mutating func run() throws {
        let jaKNBCJSONData = try Data(contentsOf: jaKNBCJSONURL)
        let jaKNBCSwiftPath = repositoryRootDirectory
            .appendingPathComponent(subDirectory)
            .appendingPathComponent("JaKNBCModel.swift")
        try generateJaKNBCCode(data: jaKNBCJSONData)
            .write(toFile: jaKNBCSwiftPath.path, atomically: true, encoding: .utf8)

        let zhHansJSONData = try Data(contentsOf: zhHansJSONURL)
        let zhHansSwiftPath = repositoryRootDirectory
            .appendingPathComponent(subDirectory)
            .appendingPathComponent("ZhHansModel.swift")
        try generateZhHansModelCode(data: zhHansJSONData)
            .write(toFile: zhHansSwiftPath.path, atomically: true, encoding: .utf8)

        let zhHantJSONData = try Data(contentsOf: zhHantJSONURL)
        let zhHantSwiftPath = repositoryRootDirectory
            .appendingPathComponent(subDirectory)
            .appendingPathComponent("ZhHantModel.swift")
        try generateZhHantModelCode(data: zhHantJSONData)
            .write(toFile: zhHantSwiftPath.path, atomically: true, encoding: .utf8)

        let thJSONData = try Data(contentsOf: thJSONURL)
        let thSwiftPath = repositoryRootDirectory
            .appendingPathComponent(subDirectory)
            .appendingPathComponent("ThModel.swift")
        try generateThModelCode(data: thJSONData)
            .write(toFile: thSwiftPath.path, atomically: true, encoding: .utf8)
    }
}

GenerateData.main()
