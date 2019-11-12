//
//  MatrixArithmeticTests.swift
//  MatrixTests
//
//  Created by Dmytro Durda on 12/11/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import XCTest
@testable import Matrix

class MatrixArithmeticTests: XCTestCase {

    func test_determinant_2x2() {
        let matrix = Matrix([[3, 8], [4, 6]])
        XCTAssertEqual(try! matrix.determinant(), -14)
    }
    
    func test_determinant_3x3() {
        let matrix = Matrix([[6, 1, 1], [4, -2, 5], [2, 8, 7]])
        XCTAssertEqual(try! matrix.determinant(), -306)
    }
    
    func test_determinant_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1]]).determinant())
        XCTAssertThrowsError(try Matrix([[1, 2], [2, 3], [3, 4]]).determinant())
    }

}
