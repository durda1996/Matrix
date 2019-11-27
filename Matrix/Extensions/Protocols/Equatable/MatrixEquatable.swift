//
//  MatrixEquatable.swift
//  Matrix
//
//  Created by Dmytro Durda on 19/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix: Equatable where Element: SignedNumeric {
    
    // Comparing Matrices with the same type
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        guard lhs.rows == rhs.rows && lhs.columns == rhs.columns else {
            return false
        }
        
        for (lhsElement, rhsElement) in zip(lhs, rhs) {
            if lhsElement != rhsElement {
                return false
            }
        }

        return true
    }
    
}

extension Matrix where Element: FloatingPoint {
    
    // Comparing Matrices with the Floating type
    
    static func ~= (lhs: Self, rhs: Self) -> Bool {
        guard lhs.rows == rhs.rows && lhs.columns == rhs.columns else {
            return false
        }
        
        for (lhsElement, rhsElement) in zip(lhs, rhs) {
            if lhsElement < rhsElement.nextDown && lhsElement > rhsElement.nextUp {
                return false
            }
        }

        return true
    }
    
}

extension Matrix where Element == Float {
    
    // Comparing Matrices with Int and Float types

    static func == (lhs: Self, rhs: Matrix<Int>) -> Bool {
        let rhsFloat = rhs.map({ Element($0) })
        return lhs == rhsFloat
    }

    static func == (lhs: Matrix<Int>, rhs: Self) -> Bool {
        let lhsFloat = lhs.map({ Element($0) })
        return lhsFloat == rhs
    }
    
}

extension Matrix where Element == Double {
    
    // Comparing Matrices with Int and Double types

    static func == (lhs: Self, rhs: Matrix<Int>) -> Bool {
        let rhsFloat = rhs.map({ Element($0) })
        return lhs == rhsFloat
    }

    static func == (lhs: Matrix<Int>, rhs: Self) -> Bool {
        let lhsFloat = lhs.map({ Element($0) })
        return lhsFloat == rhs
    }
    
    // Comparing Matrices with Float and Double types

    static func == (lhs: Self, rhs: Matrix<Float>) -> Bool {
        let rhsFloat = rhs.map({ Element($0) })
        return lhs == rhsFloat
    }

    static func == (lhs: Matrix<Float>, rhs: Self) -> Bool {
        let lhsFloat = lhs.map({ Element($0) })
        return lhsFloat == rhs
    }
    
}
