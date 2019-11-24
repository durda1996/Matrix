//
//  MatrixIndexDescription.swift
//  Matrix
//
//  Created by Dimon on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension MatrixIndex: CustomStringConvertible {
    
    var description: String {
        return "(\(row), \(column))"
    }
    
}
