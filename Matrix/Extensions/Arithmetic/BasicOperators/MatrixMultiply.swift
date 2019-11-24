//
//  MatrixMultiply.swift
//  Matrix
//
//  Created by Dimon on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix where Element: SignedNumeric {
    
    static func * (lhs: Matrix<Element>, rhs: Element) -> Matrix<Element> {
        var resultMatrix = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, repeating: 0)
        
        for index in resultMatrix.indices {
            resultMatrix[index] = lhs[index] * rhs
        }
        
        return resultMatrix
    }
    
    static func * (lhs: Element, rhs: Matrix<Element>) -> Matrix<Element> {
        return rhs * lhs
    }
    
    static func * (lhs: Matrix<Element>, rhs: Matrix<Element>) throws -> Matrix<Element> {
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
    
    static func * (lhs: Matrix<Element>, rhs: Int) -> Matrix<Element> {
        return lhs * Element(rhs)
    }
    
    static func * (lhs: Int, rhs: Matrix<Element>) -> Matrix<Element> {
        return Element(lhs) * rhs
    }
    
}

extension Matrix where Element == Float {
    
    static func * (lhs: Matrix<Element>, rhs: Matrix<Int>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs * rhsFloat
    }
    
    static func * (lhs: Matrix<Int>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat * rhs
    }
    
}

extension Matrix where Element == Double {
    
    static func * (lhs: Matrix<Element>, rhs: Matrix<Int>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs * rhsFloat
    }
    
    static func * (lhs: Matrix<Int>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat * rhs
    }
    
    static func * (lhs: Matrix<Element>, rhs: Matrix<Float>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs * rhsFloat
    }
    
    static func * (lhs: Matrix<Float>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat * rhs
    }
    
}
