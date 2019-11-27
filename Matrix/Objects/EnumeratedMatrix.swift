//
//  EnumeratedMatrix.swift
//  Matrix
//
//  Created by Dmytro Durda on 17/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

struct EnumeratedMatrix<Element: Equatable> {
    typealias EnumeratedMatrixResult = (offset: MatrixIndex, value: Element)
    
    private let matrix: Matrix<Element>
    
    init(_ matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    func reversed() -> [EnumeratedMatrixResult] {
        var enumeratedMatrixSequence = [EnumeratedMatrixResult]()
        let revercedMatrix = matrix.reversed()
        
        for index in revercedMatrix.grid.indices {
            enumeratedMatrixSequence.append((revercedMatrix.indices[index], revercedMatrix.grid[index]))
        }
        
        return enumeratedMatrixSequence
    }
}

extension EnumeratedMatrix: Sequence {
    func makeIterator() -> EnumeratedMatrixIterator<Element> {
        return EnumeratedMatrixIterator(matrix)
    }
}

struct EnumeratedMatrixIterator<Element: Equatable>: IteratorProtocol {
    typealias EnumeratedMatrixResult = EnumeratedMatrix<Element>.EnumeratedMatrixResult
    
    private let matrix: Matrix<Element>
    private var index = 0
    
    init(_ matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    mutating func next() -> EnumeratedMatrixResult? {
        guard index < matrix.grid.count else {
            return nil
        }
        
        let currentValue = matrix.grid[index]
        let currentIndex = matrix.indices[index]
        index += 1
        
        return (currentIndex, currentValue)
    }
}
