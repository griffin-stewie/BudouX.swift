//
//  Utils.swift
//  
//
//  Created by griffin-stewie on 2021/12/16.
//  
//

import Foundation


/// the same as Python's bisect.bisect_right method
///
/// Finds the insertion point maintaining the sorted order with a basic
/// bisection algorithm. This works the same as Python's bisect.bisect_right
/// method.
/// - Parameters:
///   - arr: The sorted array.
///   - i: The item to check the insertion point.
/// - Returns: The insertion point.
func bisectRight(arr:[Int], i: Int) -> Int {
    let mid = Int(floor(Double(arr.count/2)))
    if i == arr[mid] {
        return mid + 1
    } else if i < arr[mid] {
        if arr.count == 1 {
            return 0
        }
        return bisectRight(arr: Array(arr.prefix(upTo: mid)), i: i)
    } else {
        if arr.count == 1 {
            return 1
        }
        return mid + bisectRight(arr: Array(arr.suffix(from: mid)), i: i)
    }
}

/** The separator string to specify breakpoints. */
let SEP = "_"
