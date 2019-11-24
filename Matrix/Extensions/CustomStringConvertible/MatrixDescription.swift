//
//  MatrixDescription.swift
//  Matrix
//
//  Created by Dimon on 24/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

extension Matrix: CustomStringConvertible where Element: LosslessStringConvertible {
    
    var description: String {
        let rowVectorStrings = rowVectors.map({ rowVector -> String in
            var rowVectorString = "["
            rowVectorString.append(rowVector.map({ String($0) }).joined(separator: ", "))
            rowVectorString.append("]")

            return rowVectorString
        })
        
        return rowVectorStrings.joined(separator: "\n")
    }
    
}
