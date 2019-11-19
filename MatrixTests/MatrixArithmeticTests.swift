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

    // MARK: - Determinant
    
    func test_determinant_1x1_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1]]).determinant())
    }
    
    func test_determinant_2x2() {
        let matrix = Matrix([[3, 8], [4, 6]])
        let determinant = try! matrix.determinant()
        XCTAssertEqual(determinant, -14)
    }
    
    func test_determinant_3x2_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1, 2], [2, 3], [3, 4]]).determinant())
    }
    
    func test_determinant_3x3() {
        let matrix = Matrix([[6, 1, 1], [4, -2, 5], [2, 8, 7]])
        let determinant = try! matrix.determinant()
        XCTAssertEqual(determinant, -306)
    }
    
    // MARK: - Minors
    
    func test_minors_1x1_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1]]).minors())
    }
    
    func test_minors_2x2() {
        let matrix = Matrix([[3, 8], [4, 6]])
        let minorMatrix = try! matrix.minors()
        let expectedResult = Matrix([[6, 4], [8, 3]])
        XCTAssertEqual(minorMatrix, expectedResult)
    }
    
    func test_minors_3x2_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1, 2], [2, 3], [3, 4]]).minors())
    }
    
    func test_minors_3x3() {
        let matrix = Matrix([[1, 2, 1], [6, -1, 0], [-1, -2, -1]])
        let minorMatrix = try! matrix.minors()
        let expectedResult = Matrix([[1, -6, -13], [0, 0, 0], [1, -6, -13]])
        XCTAssertEqual(minorMatrix, expectedResult)
    }
    
    // MARK: - Cofactors
    
    func test_cofactors_1x1_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1]]).cofactors())
    }
    
    func test_cofactors_2x2() {
        let matrix = Matrix([[3, 8], [0, 6]])
        let cofactorsMatrix = try! matrix.cofactors()
        let expectedResult = Matrix([[6, 0], [-8, 3]])
        XCTAssertEqual(cofactorsMatrix, expectedResult)
    }
    
    func test_cofactors_3x2_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1, 2], [2, 3], [3, 4]]).cofactors())
    }
    
    func test_cofactors_3x3() {
        let matrix = Matrix([[1, 2, 1], [6, -1, 0], [-1, -2, -1]])
        let cofactorsMatrix = try! matrix.cofactors()
        let expectedResult = Matrix([[1, 6, -13], [0, 0, 0], [1, 6, -13]])
        XCTAssertEqual(cofactorsMatrix, expectedResult)
    }
    
    // MARK: - Transpose
    
    func test_transpose_1x1() {
        let matrix = Matrix([[3]])
        let transposedMatrix = matrix.transposed()
        let expectedResult = Matrix([[3]])
        XCTAssertEqual(transposedMatrix, expectedResult)
    }
    
    func test_transpose_2x2() {
        let matrix = Matrix([[3, 8], [0, 6]])
        let transposedMatrix = matrix.transposed()
        let expectedResult = Matrix([[3, 0], [8, 6]])
        XCTAssertEqual(transposedMatrix, expectedResult)
    }
    
    func test_transpose_3x2() {
        let matrix = Matrix([[1, -4], [2, 3], [2, 0]])
        let transposedMatrix = matrix.transposed()
        let expectedResult = Matrix([[1, 2, 2], [-4, 3, 0]])
        XCTAssertEqual(transposedMatrix, expectedResult)
    }
    
    func test_transpose_3x3() {
        let matrix = Matrix([[2, 2, 2], [-2, 3, 3], [0, -10, 0]])
        let transposedMatrix = matrix.transposed()
        let expectedResult = Matrix([[2, -2, 0], [2, 3, -10], [2, 3, 0]])
        XCTAssertEqual(transposedMatrix, expectedResult)
    }
    
    // MARK: - Adjugate
    
    func test_adjugate_3x3() {
        let matrix = Matrix([[-3, 2, -5], [-1, 0, -2], [3, -4, 1]])
        let adjugatedMatrix = try! matrix.adjugated()
        let expectedResult = Matrix([[-8, 18, -4], [-5, 12, -1], [4, -6, 2]])
        XCTAssertEqual(adjugatedMatrix, expectedResult)
    }
    
    // MARK: - Add Operator
    
    func test_add_matrices_2x2() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2.1], [4, 1]])
        let result = try! firstMatrix + secondMatrix
        let expectedResult = Matrix([[8, 0], [6, 1]])
        XCTAssertTrue(result == expectedResult)
    }
    
    func test_add_matrices_withDifferentSizes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2, 3.4], [4, 1, 2]])
        XCTAssertThrowsError(try firstMatrix + secondMatrix)
    }
    
    func test_add_matrices_withDifferentTypes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2], [4, 1]])
        let result = try! firstMatrix + secondMatrix
        let expectedResult = Matrix([[8, 0.1], [6, 1]])
        XCTAssertTrue(result == expectedResult)
    }
    
    // MARK: - Subtract Operator
    
    func test_subtract_matrices_2x2() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2.1], [4, 1]])
        let result = try! firstMatrix - secondMatrix
        let expectedResult = Matrix([[-2, 4.2], [-2, -1]])
        XCTAssertTrue(result == expectedResult)
    }
    
    func test_subtract_matrices_differentSizes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2, 3.4], [4, 1, 2]])
        XCTAssertThrowsError(try firstMatrix - secondMatrix)
    }
    
    func test_subtract_matrices_withDifferentTypes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2], [4, 1]])
        let result = try! firstMatrix - secondMatrix
        let expectedResult = Matrix([[-2, 4.1], [-2, -1]])
        XCTAssertTrue(result == expectedResult)
    }
    
    // MARK: - Multiply Operator
    
    func test_multiply_matrices_2x2() {
        let firstMatrix = Matrix([[3, 2], [2, 0]])
        let secondMatrix = Matrix([[5, -2], [4, 1]])
        let result = try! firstMatrix * secondMatrix
        let expectedResult = Matrix([[23, -4], [10, -4]])
        XCTAssertTrue(result == expectedResult)
    }
    
}


