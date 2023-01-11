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

    let jaKNBCJSONURL: URL = URL(string: "https://raw.githubusercontent.com/google/budoux/main/budoux/models/ja.json")!
    let zhHansJSONURL: URL = URL(string: "https://raw.githubusercontent.com/google/budoux/main/budoux/models/zh-hans.json")!
    let zhHantJSONURL: URL = URL(string: "https://raw.githubusercontent.com/google/budoux/main/budoux/models/zh-hant.json")!

    @Option(name: [.short, .customLong("repo-root")], help: "The GitHub repository to search for changes.")
    var repositoryRootDirectory: URL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

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
                public let featureAndScore: [String: Int] = \(jsonStr)
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
                public let featureAndScore: [String: Int] = \(jsonStr)
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
                public let featureAndScore: [String: Int] = \(jsonStr)
            }
            """
    }

    mutating func run() throws {
        let jaKNBCJSONData = try Data(contentsOf: jaKNBCJSONURL)
        let jaKNBCSwiftPath = repositoryRootDirectory.appendingPathComponent("Sources/BudouX/Data/JaKNBCModel.swift")
        try generateJaKNBCCode(data: jaKNBCJSONData)
            .write(toFile: jaKNBCSwiftPath.path, atomically: true, encoding: .utf8)

        let zhHansJSONData = try Data(contentsOf: zhHansJSONURL)
        let zhHansSwiftPath = repositoryRootDirectory.appendingPathComponent("Sources/BudouX/Data/ZhHansModel.swift")
        try generateZhHansModelCode(data: zhHansJSONData)
            .write(toFile: zhHansSwiftPath.path, atomically: true, encoding: .utf8)

        let zhHantJSONData = try Data(contentsOf: zhHantJSONURL)
        let zhHantSwiftPath = repositoryRootDirectory.appendingPathComponent("Sources/BudouX/Data/ZhHantModel.swift")
        try generateZhHantModelCode(data: zhHantJSONData)
            .write(toFile: zhHantSwiftPath.path, atomically: true, encoding: .utf8)
    }
}

GenerateData.main()
