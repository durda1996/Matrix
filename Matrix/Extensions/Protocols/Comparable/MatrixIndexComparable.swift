//
//  MatrixIndexComparable.swift
//  Matrix
//
//  Created by Dmytro Durda on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension MatrixIndex: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.row < rhs.row {
            return true
        }

        if lhs.row == rhs.row {
            return lhs.column < rhs.column
        }

        return false
    }

    static func > (lhs: Self, rhs: Self) -> Bool {
        if lhs.row > rhs.row {
            return true
        }

        if lhs.row == rhs.row {
            return lhs.column > rhs.column
        }

        return false
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.row == rhs.row && lhs.column == rhs.column
    }
    
}
