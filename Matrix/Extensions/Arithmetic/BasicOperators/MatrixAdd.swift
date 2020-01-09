//
//  MatrixAdd.swift
//  Matrix
//
//  Created by Dmytro Durda on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix where Element: SignedNumeric {
    
    static func + (lhs: Self, rhs: Self) throws -> Self {
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
    
    static func + (lhs: Self, rhs: Matrix<Int>) throws -> Self {
        let rhsFloat = Matrix<Element>(rows: rhs.rows, columns: rhs.columns, grid: rhs.map{Element($0)})
        return try lhs + rhsFloat
    }
    
    static func + (lhs: Matrix<Int>, rhs: Self) throws -> Self {
        let lhsFloat = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, grid: lhs.map{Element($0)})
        return try lhsFloat + rhs
    }

}

extension Matrix where Element == Double {
    
    static func + (lhs: Self, rhs: Matrix<Int>) throws -> Self {
        let rhsDouble = Matrix<Element>(rows: rhs.rows, columns: rhs.columns, grid: rhs.map{Element($0)})
        return try lhs + rhsDouble
    }
    
    static func + (lhs: Matrix<Int>, rhs: Self) throws -> Self {
        let lhsDouble = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, grid: lhs.map{Element($0)})
        return try lhsDouble + rhs
    }
    
    static func + (lhs: Self, rhs: Matrix<Float>) throws -> Self {
        let rhsDouble = Matrix<Element>(rows: rhs.rows, columns: rhs.columns, grid: rhs.map{Element($0)})
        return try lhs + rhsDouble
    }
    
    static func + (lhs: Matrix<Float>, rhs: Self) throws -> Self {
        let lhsDouble = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, grid: lhs.map{Element($0)})
        return try lhsDouble + rhs
    }

}
