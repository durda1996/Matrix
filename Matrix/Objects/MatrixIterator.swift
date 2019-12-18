//
//  MatrixIterator.swift
//  Matrix
//
//  Created by Dmytro Durda on 17/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

struct MatrixIterator<Element: Equatable>: IteratorProtocol {
    private let matrix: Matrix<Element>
    private var index = 0
    
    init(_ matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    mutating func next() -> Element? {
        guard index < matrix.grid.count else {
            return nil
        }
        
        let currentValue = matrix.grid[index]
        index += 1
        
        return currentValue
    }
}

extension Matrix: Sequence {
    func makeIterator() -> MatrixIterator<Element> {
        return MatrixIterator(self)
    }
}
