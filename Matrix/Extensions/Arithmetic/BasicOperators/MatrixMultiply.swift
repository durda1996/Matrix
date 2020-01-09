//
//  MatrixMultiply.swift
//  Matrix
//
//  Created by Dmytro Durda on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix where Element: SignedNumeric {
    
    static func * (lhs: Self, rhs: Element) -> Self {
        var resultMatrix = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, repeating: 0)
        
        for index in resultMatrix.indices {
            resultMatrix[index] = lhs[index] * rhs
        }
        
        return resultMatrix
    }
    
    static func * (lhs: Element, rhs: Self) -> Self {
        return rhs * lhs
    }
    
    static func * (lhs: Self, rhs: Self) throws -> Self {
        guard lhs.columns == rhs.rows else {
            throw MatrixError.inconsistentSize(description: "The number of columns in the first matrix must be equal to the number of rows in the second matrix.")
        }
        
        var resultMatrix = Matrix<Element>(rows: lhs.rows, columns: rhs.columns, repeating: 0)
        
        for (lhsIndex, lhsRowVector) in lhs.rowVectors.enumerated() {
            for (rhsIndex, rhsColumnVector) in rhs.columnVectors.enumerated() {
                var value: Element = 0
                
                for vectorIndex in 0..<lhsRowVector.count {
                    value += lhsRowVector[vectorIndex] * rhsColumnVector[vectorIndex]
                }
                
                resultMatrix[lhsIndex, rhsIndex] = value
            }
        }
        
        return resultMatrix
    }
    
}

extension Matrix where Element: FloatingPoint {
    
    static func * (lhs: Self, rhs: Int) -> Self {
        return lhs * Element(rhs)
    }
    
    static func * (lhs: Int, rhs: Self) -> Self {
        return Element(lhs) * rhs
    }
    
}

extension Matrix where Element == Float {
    
    static func * (lhs: Self, rhs: Matrix<Int>) throws -> Self {
        let rhsFloat = Matrix<Element>(rows: rhs.rows, columns: rhs.columns, grid: rhs.map{Element($0)})
        return try lhs * rhsFloat
    }
    
    static func * (lhs: Matrix<Int>, rhs: Self) throws -> Self {
        let lhsFloat = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, grid: lhs.map{Element($0)})
        return try lhsFloat * rhs
    }
    
}

extension Matrix where Element == Double {
    
    static func * (lhs: Self, rhs: Matrix<Int>) throws -> Self {
        let rhsDouble = Matrix<Element>(rows: rhs.rows, columns: rhs.columns, grid: rhs.map{Element($0)})
        return try lhs * rhsDouble
    }
    
    static func * (lhs: Matrix<Int>, rhs: Self) throws -> Self {
        let lhsDouble = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, grid: lhs.map{Element($0)})
        return try lhsDouble * rhs
    }
    
    static func * (lhs: Self, rhs: Matrix<Float>) throws -> Self {
        let rhsDouble = Matrix<Element>(rows: rhs.rows, columns: rhs.columns, grid: rhs.map{Element($0)})
        return try lhs * rhsDouble
    }
    
    static func * (lhs: Matrix<Float>, rhs: Self) throws -> Self {
        let lhsDouble = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, grid: lhs.map{Element($0)})
        return try lhsDouble * rhs
    }
    
}
