//
//  MatrixArithmetic.swift
//  Matrix
//
//  Created by Dmytro Durda on 05/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

enum DeterminantError: Error {
    case inconsistentSize
    
    var localizedDescription: String {
        switch self {
        case .inconsistentSize:
            return "Rows and columns size MUST be the same and lerger than 2"
        }
    }
}

extension Matrix where Element: Numeric {
    
    func determinant() throws -> Element {
        guard rows >= 2, columns >= 2, rows == columns else {
            throw DeterminantError.inconsistentSize
        }
        
        if rows == 2 && columns == 2 {
            return (self[0, 0] * self[1, 1]) - (self[0, 1] * self[1, 0])
        }
        
        var determinant: Element = 0
        
        for column in 0..<columns {
            let value = self[0, column]
            
            var submatrix: Matrix<Element> {
                var matrixCopy = self
                matrixCopy.removeFirstRowVector()
                matrixCopy.removeColumnVector(at: column)
                return matrixCopy
            }
            
            let subdeterminant = try! submatrix.determinant()
            let result = value * subdeterminant
            
            if column % 2 == 0 {
                determinant += result
            } else {
                determinant -= result
            }
        }
        
        return determinant
    }
    
}
