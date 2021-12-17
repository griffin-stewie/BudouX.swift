//
//  main.swift
//  
//
//  Created by griffin-stewie on 2021/12/17.
//  
//

import Foundation
import BudouX
import ArgumentParser

struct MainCommand: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "budoux-swift",
        abstract: "budoux-swift is BudouX swift port. BudouX is the successor to Budou, the machine learning powered line break organizer tool.",
        version: "1.0.0"
    )

    @Argument(help: ArgumentHelp("text", valueName: "TXT"))
    var input: String

    func run() throws {
        let parser = Parser()
        let results = parser.parse(sentence: input)
        for t in results {
            print(t)
        }
    }
}

MainCommand.main()
