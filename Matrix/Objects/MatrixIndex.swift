//
//  MatrixIndex.swift
//  Matrix
//
//  Created by Dmytro Durda on 16/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

struct MatrixIndex {
    let row: Int
    let column: Int
}
    
extension MatrixIndex: Comparable {
    static func < (lhs: MatrixIndex, rhs: MatrixIndex) -> Bool {
        if lhs.row < rhs.row {
            return true
        }

        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        }

        return false
    }

    static func > (lhs: MatrixIndex, rhs: MatrixIndex) -> Bool {
        if lhs.row > rhs.row {
            return true
        }

        if lhs.row == rhs.row {
            return lhs.column > rhs.column
        }

        return false
    }

    static func == (lhs: MatrixIndex, rhs: MatrixIndex) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
}

extension MatrixIndex: CustomStringConvertible {
    var description: String {
        return "(\(row), \(column))"
    }
}
