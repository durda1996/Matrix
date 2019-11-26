//
//  MatrixPower.swift
//  Matrix
//
//  Created by Dmytro Durda on 26/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix where Element: SignedNumeric {
    
    static func ^ (lhs: Matrix<Element>, rhs: Int) throws -> Matrix<Element> {
        var result = lhs
        
        for _ in 1..<rhs {
            result = try result * lhs
        }
        
        return result
    }
    
}
