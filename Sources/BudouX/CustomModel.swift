//
//  CustomModel.swift
//  
//
//  Created by griffin-stewie on 2023/06/15.
//  
//

import Foundation

public struct CustomModel: Model {
    public let supportedNaturalLanguages: Set<String>
    public let featureAndScore: [String: [String: Int]]

    public init(modelJSON: Data, supportedNaturalLanguages: Set<String>) throws {
        featureAndScore = try JSONDecoder().decode([String: [String: Int]].self, from: modelJSON)
        self.supportedNaturalLanguages = supportedNaturalLanguages
    }
}
