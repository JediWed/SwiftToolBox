//
//  File.swift
//  
//
//  Created by Ediz Turcan on 04.02.20.
//

import Foundation

public extension Comparable {

    /// Use this function to make sure the value is between given bounds.
    ///
    /// - Parameter limits: ClosedRange from lower to upper bound
    /// - Returns:
    ///         limits.lowerBound, if self is below limits,
    ///         self, if self is between limits
    ///         or limits.upperBound, if self is above limits.
    func stbClamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
