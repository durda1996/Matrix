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
    
    func minor(row: Int, column: Int) -> Self {
        var matrixCopy = self
        matrixCopy.removeRowVector(at: row)
        matrixCopy.removeColumnVector(at: column)
        return matrixCopy
    }
    
    func minors() throws -> Self {
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
    
    func cofactors() throws -> Self {
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
    
    func adjugated() throws -> Self {
        let matrixOfCofactors = try cofactors()
        let transposedMatrix = matrixOfCofactors.transposed()
        
        return transposedMatrix
    }
    
    func transposed() -> Self {
        let matrixCopy = self
        var transposedMatrix = Matrix<Element>()
        
        for rowVector in matrixCopy.rowVectors {
            transposedMatrix.append(columnVector: rowVector)
        }
        
        return transposedMatrix
    }
    
}

extension Matrix where Element: FloatingPoint {
    
    func inversed() throws -> Self {
        var adjugatedMatrix = try adjugated()
        let matrixDeterminant = try determinant()
        
        for index in adjugatedMatrix.indices {
            let value = adjugatedMatrix[index]
            let inversedValue = value / matrixDeterminant
            adjugatedMatrix[index] = inversedValue
        }
        
        return adjugatedMatrix
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
