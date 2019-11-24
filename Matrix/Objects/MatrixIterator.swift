//
//  MatrixIterator.swift
//  Matrix
//
//  Created by Dmytro Durda on 17/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

struct MatrixIterator<Element>: IteratorProtocol {
    private let values: [Element]
    private var index = 0
    
    init(_ values: [Element]) {
        self.values = values
    }
    
    mutating func next() -> Element? {
        guard index < values.count else {
            return nil
        }
        
        let currentValue = values[index]
        index += 1
        
        return currentValue
    }
}

extension Matrix: Sequence {
    func makeIterator() -> MatrixIterator<Element> {
        return MatrixIterator(grid)
    }
}
