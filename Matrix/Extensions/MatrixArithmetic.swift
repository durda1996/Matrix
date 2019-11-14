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
    
    func cofactors() -> Matrix<Element> {
        var matrixCopy = self
        
        for row in 0..<rows {
            let minusesInRow = (0..<columns).filter({ (row % 2 == 0) ? ($0 % 2 != 0) : ($0 % 2 == 0) })
            for minusColumn in minusesInRow {
                let value = matrixCopy[row, minusColumn]
                matrixCopy[row, minusColumn] = -value
            }
        }
        
        return matrixCopy
    }
    
    func adjugated() -> Matrix<Element> {
        var matrixCopy = self
        var topRow = 0
        var topColumn = 0
        var bottomRow = 0
        var bottomColumn = 0
        
        while topRow < rows && topColumn < columns {
            if topColumn < columns {
                topColumn += 1
            }
            
            if topColumn == columns {
                topRow += 1
            }
            
            if bottomRow < rows {
                bottomRow += 1
            }
            
            if bottomRow == rows {
                bottomColumn += 1
            }
            
            let topIndex = MatrixIndex(row: topRow, column: topColumn)
            let bottomIndex = MatrixIndex(row: bottomRow, column: bottomRow)
            matrixCopy.swapAt(topIndex, bottomIndex)
        }
        
        return matrixCopy
    }
    
}

extension Matrix where Element: FloatingPoint {
    
    func inversed() throws -> Matrix<Element> {
        // order matters!
        let matrixCopy = self
        let matrixOfMinors = try matrixCopy.minors()
        let matrixOfCofactors = matrixOfMinors.cofactors()
        var adjugatedMatrix = matrixOfCofactors.adjugated()
        let determinant = try matrixCopy.determinant()
        
        for index in adjugatedMatrix.indices {
            let value = adjugatedMatrix[index]
            let inversedValue = value / determinant
            adjugatedMatrix[index] = inversedValue
        }
        
        return adjugatedMatrix
    }
    
}

extension Matrix where Element: SignedInteger {
    
    func inversed() throws -> Matrix<Float> {
        // order matters!
        let matrixCopy = self
        let matrixOfMinors = try matrixCopy.minors()
        let matrixOfCofactors = matrixOfMinors.cofactors()
        let adjugatedMatrix = matrixOfCofactors.adjugated()
        let determinant = try matrixCopy.determinant()
        var resultMatrix = Matrix<Float>(rows: adjugatedMatrix.rows, columns: adjugatedMatrix.columns, repeating: 0)
        
        for index in adjugatedMatrix.indices {
            let value = adjugatedMatrix[index]
            let inversedValue: Float = Float(value / determinant)
            resultMatrix[index] = inversedValue
        }
        
        return resultMatrix
    }
    
}
