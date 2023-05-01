//
//  Model.swift
//
//
//  Created by griffin-stewie on 2021/12/21.
//
//

/// ML Model.
public protocol Model {
    var supportedNaturalLanguages: Set<String> { get }
    var featureAndScore: [String: [String: Int]] { get }
}
