//
//  MatrixAdd.swift
//  Matrix
//
//  Created by Dmytro Durda on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix where Element: SignedNumeric {
    
    static func + (lhs: Matrix<Element>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        guard lhs.rows == rhs.rows && lhs.columns == rhs.columns else {
            throw MatrixError.inconsistentSize(description: "Matrices MUST have the same size to complete this operation")
        }
        
        var resultMatrix = Matrix(rows: lhs.rows, columns: lhs.columns, repeating: 0)
        
        for index in resultMatrix.indices {
            resultMatrix[index] = lhs[index] + rhs[index]
        }
        
        return resultMatrix
    }
    
}

extension Matrix where Element == Float {
    
    static func + (lhs: Matrix<Element>, rhs: Matrix<Int>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs + rhsFloat
    }
    
    static func + (lhs: Matrix<Int>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat + rhs
    }

}

extension Matrix where Element == Double {
    
    static func + (lhs: Matrix<Element>, rhs: Matrix<Int>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs + rhsFloat
    }
    
    static func + (lhs: Matrix<Int>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat + rhs
    }
    
    static func + (lhs: Matrix<Element>, rhs: Matrix<Float>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs + rhsFloat
    }
    
    static func + (lhs: Matrix<Float>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat + rhs
    }

}
