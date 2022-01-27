//
//  CustomModel.swift
//
//
//  Created by treastrain on 2022/01/19.
//

import BudouX
import Foundation

struct CustomModel: Model {
    let supportedNaturalLanguages: Set<String>
    let featureAndScore: [String: Int]
}
