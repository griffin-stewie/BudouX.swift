//
//  Utils.swift
//
//
//  Created by griffin-stewie on 2021/12/16.
//
//

import Foundation

/// The separator string to specify breakpoints.
let separator = "_"


/// The invalid feature string.
let invalid = "▔"

extension Collection where Element == Int {
    func sum() -> Int {
        reduce(0, +)
    }
}
