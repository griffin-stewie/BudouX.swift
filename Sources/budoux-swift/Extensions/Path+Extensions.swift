//
//  Path+Extensions.swift
//  
//
//  Created by griffin-stewie on 2022/12/10.
//  
//

import Foundation
import ArgumentParser
import Path

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
