//
//  EnumeratedMatrix.swift
//  Matrix
//
//  Created by Dmytro Durda on 17/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

struct EnumeratedMatrix<Element> where Element: Equatable {
    private let matrix: Matrix<Element>
    
    init(_ matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    
}

extension EnumeratedMatrix: Sequence {
    
    func makeIterator() -> EnumeratedMatrixIterator<Element> {
        return EnumeratedMatrixIterator(matrix)
    }
    
}

struct EnumeratedMatrixIterator<Element>: IteratorProtocol where Element: Equatable {
    private let matrix: Matrix<Element>
    private var index = 0
    
    init(_ matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    mutating func next() -> (offset: MatrixIndex, value: Element)? {
        guard index < matrix.grid.count else {
            return nil
        }
        
        let currentValue = matrix.grid[index]
        let currentIndex = matrix.indices[index]
        index += 1
        
        return (currentIndex, currentValue)
    }
}
