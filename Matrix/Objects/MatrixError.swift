//
//  MatrixError.swift
//  Matrix
//
//  Created by Dmytro Durda on 14/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

enum MatrixError: Error {
    case inconsistentSize(description: String)
    case calculationError(description: String)
    
    var localizedDescription: String {
        switch self {
        case .inconsistentSize(let description):
            return "Inconsistent matrix size: \(description)"
        case .calculationError(let description):
            return "Calculation Error: \(description)"
        }
    }
}
