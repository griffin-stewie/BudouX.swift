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

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        return reduce(.zero, +)
    }
}

extension String {
    func index(of i: Int) -> String.Index? {
        guard i >= 0 else {
            return nil
        }

        guard let strIndex = index(startIndex, offsetBy: i, limitedBy: endIndex) else {
            return nil
        }

        return strIndex
    }

    func string(at index: Int) -> String? {
        guard let strIndex = self.index(of: index) else {
            return nil
        }

        if strIndex == endIndex {
            return nil
        }
        
        return String(self[strIndex])
    }
    
    func slice(_ indexStart: Int, _ indexEnd: Int) -> String? {
        if indexStart == 0, indexEnd == 0 {
            return nil
        }

        if indexEnd == 0 {
            return nil
        }

        if count <= indexStart {
            return nil
        }

        if indexStart == indexEnd {
            return nil
        }

        if 0 <= indexStart, 0 < indexEnd {
            guard let indexBegins = index(startIndex, offsetBy: indexStart, limitedBy: endIndex) else {
                return nil
            }

            let indexEnds = index(startIndex, offsetBy: indexEnd, limitedBy: endIndex) ?? endIndex
            return String(self[indexBegins..<indexEnds])
        } else if indexStart < 0, 0 < indexEnd {
            return nil
        } else if indexStart < 0, indexEnd < 0  {
            let start = max(indexStart + self.count, 0)
            let end = max(indexEnd + self.count, 0)

            guard let indexBegins = self.index(of: start) else {
                return nil
            }

            guard let indexEnds = self.index(of: end) else {
                return nil
            }

            return String(self[indexBegins..<indexEnds])
        } else if 0 <= indexStart, indexEnd < 0 {
            guard let indexBegins = self.index(of: indexStart) else {
                return nil
            }

            let end = max(indexEnd + self.count, 0)
            guard let indexEnds = self.index(of: end) else {
                return nil
            }

            return String(self[indexBegins..<indexEnds])
        } else {
            fatalError("else")
        }
    }

    func slice(_ indexStart: Int) -> String? {
        if indexStart < 0 {
            let start = max(indexStart + self.count, 0)
            return self.slice(start)
        } else {
            guard let strIndex = self.index(of: indexStart) else {
                return nil
            }
            
            return String(self[strIndex..<endIndex])
        }
    }
}
