//
//  MatrixArithmetic.swift
//  Matrix
//
//  Created by Dmytro Durda on 05/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix where Element: SignedNumeric {
    
    func determinant() throws -> Element {
        guard rows >= 2, columns >= 2, rows == columns else {
            throw MatrixError.inconsistentSize(description: "Rows and columns count MUST be the same and larger than 2")
        }
        
        if rows == 2 && columns == 2 {
            return (self[0, 0] * self[1, 1]) - (self[0, 1] * self[1, 0])
        }
        
        var determinant: Element = 0
        
        for column in 0..<columns {
            let value = self[0, column]
            let minorMatrix = minor(row: 0, column: column)
            let minorDeterminant = try! minorMatrix.determinant()
            let result = value * minorDeterminant
            
            if column % 2 == 0 {
                determinant += result
            } else {
                determinant -= result
            }
        }
        
        return determinant
    }
    
    func minor(row: Int, column: Int) -> Matrix<Element> {
        var matrixCopy = self
        matrixCopy.removeRowVector(at: row)
        matrixCopy.removeColumnVector(at: column)
        return matrixCopy
    }
    
    func minors() throws -> Matrix<Element> {
        guard rows >= 2, columns >= 2, rows == columns else {
            throw MatrixError.inconsistentSize(description: "Rows and columns count MUST be the same and larger than 2")
        }
        
        var matrixCopy = self
        
        if rows == 2 && columns == 2 {
            matrixCopy.swapAt(MatrixIndex(row: 0, column: 0), MatrixIndex(row: 1, column: 1))
            matrixCopy.swapAt(MatrixIndex(row: 0, column: 1), MatrixIndex(row: 1, column: 0))
            return matrixCopy
        }
        
        for row in 0..<rows {
            for column in 0..<columns {
                let minorMatrix = minor(row: row, column: column)
                let minorDeterminant = try! minorMatrix.determinant()
                matrixCopy[row, column] = minorDeterminant
            }
        }
        
        return matrixCopy
    }
    
    func cofactors() throws -> Matrix<Element> {
        var matrixOfMinors = try minors()
        
        for row in 0..<rows {
            let minusesInRow = (0..<columns).filter({ (row % 2 == 0) ? ($0 % 2 != 0) : ($0 % 2 == 0) })
            for minusColumn in minusesInRow {
                let value = matrixOfMinors[row, minusColumn]
                matrixOfMinors[row, minusColumn] = -value
            }
        }
        
        return matrixOfMinors
    }
    
    func adjugated() throws -> Matrix<Element> {
        let matrixOfCofactors = try cofactors()
        let transposedMatrix = matrixOfCofactors.transposed()
        
        return transposedMatrix
    }
    
    func transposed() -> Matrix<Element> {
        let matrixCopy = self
        var transposedMatrix = Matrix<Element>()
        
        for rowVector in matrixCopy.rowVectors {
            transposedMatrix.append(columnVector: rowVector)
        }
        
        return transposedMatrix
    }
    
}

extension Matrix where Element: FloatingPoint {
    
    func inversed() throws -> Matrix<Element> {
        var adjugatedMatrix = try adjugated()
        let matrixDeterminant = try determinant()
        
        for index in adjugatedMatrix.indices {
            let value = adjugatedMatrix[index]
            let inversedValue = value / matrixDeterminant
            adjugatedMatrix[index] = inversedValue
        }
        
        return adjugatedMatrix
    }
    
    // MARK: - Basic Operators
    
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
    
    static func - (lhs: Matrix<Element>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        guard lhs.rows == rhs.rows && lhs.columns == rhs.columns else {
            throw MatrixError.inconsistentSize(description: "Matrices MUST have the same size to complete this operation")
        }
        
        var resultMatrix = Matrix(rows: lhs.rows, columns: lhs.columns, repeating: 0)
        
        for index in resultMatrix.indices {
            resultMatrix[index] = lhs[index] - rhs[index]
        }
        
        return resultMatrix
    }
    
    static func * (lhs: Matrix<Element>, rhs: Element) -> Matrix<Element> {
        var resultMatrix = Matrix<Element>(rows: lhs.rows, columns: lhs.columns, repeating: 0)
        
        for index in resultMatrix.indices {
            resultMatrix[index] = lhs[index] * rhs
        }
        
        return resultMatrix
    }
    
    static func * (lhs: Matrix<Element>, rhs: Int) -> Matrix<Element> {
        return lhs * Element(rhs)
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

extension Matrix where Element: SignedInteger {
    
    func inversed() throws -> Matrix<Float> {
        let adjugatedMatrix = try adjugated()
        let matrixDeterminant = try determinant()
        var resultMatrix = Matrix<Float>(rows: adjugatedMatrix.rows, columns: adjugatedMatrix.columns, repeating: 0)
        
        for index in adjugatedMatrix.indices {
            let value = adjugatedMatrix[index]
            let inversedValue: Float = Float(value / matrixDeterminant)
            resultMatrix[index] = inversedValue
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
    
    static func - (lhs: Matrix<Element>, rhs: Matrix<Int>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs - rhsFloat
    }
    
    static func - (lhs: Matrix<Int>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat - rhs
    }
    
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
    
    static func - (lhs: Matrix<Element>, rhs: Matrix<Int>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs - rhsFloat
    }
    
    static func - (lhs: Matrix<Int>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat - rhs
    }
    
    static func - (lhs: Matrix<Element>, rhs: Matrix<Float>) throws -> Matrix<Element> {
        let rhsFloat = rhs.map({ Element($0) })
        return try lhs - rhsFloat
    }
    
    static func - (lhs: Matrix<Float>, rhs: Matrix<Element>) throws -> Matrix<Element> {
        let lhsFloat = lhs.map({ Element($0) })
        return try lhsFloat - rhs
    }
    
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
