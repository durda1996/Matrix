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
    
    // MARK: - Adjugate
    
    func test_inverse_2x2_zeroDeterminant() {
        XCTAssertThrowsError(try Matrix([[3, 4], [6, 8]]).inversed())
    }
    
    func test_inverse_3x3() {
        let matrix = Matrix([[3, 0, 2], [2, 0, -2], [0, 1, 1]])
        let inversedMatrix: Matrix<Double> = try! matrix.inversed()
        let expectedResult = Matrix([[0.2, 0.2, 0], [-0.2, 0.3, 1], [0.2, -0.3, 0]])
        XCTAssertTrue(inversedMatrix ~= expectedResult)
    }
    
    // MARK: - Add Operator
    
    func test_add_matrices_2x2() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2.1], [4, 1]])
        let result = try! firstMatrix + secondMatrix
        let expectedResult = Matrix([[8, 0], [6, 1]])
        XCTAssertTrue(result == expectedResult)
    }
    
    func test_add_matrices_differentSizes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2, 3.4], [4, 1, 2]])
        XCTAssertThrowsError(try firstMatrix + secondMatrix)
    }
    
    func test_add_matrices_differentTypes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2], [4, 1]])
        let result = try! firstMatrix + secondMatrix
        let expectedResult = Matrix([[8, 0.1], [6, 1]])
        XCTAssertTrue(result ~= expectedResult)
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
    
    func test_subtract_matrices_differentTypes() {
        let firstMatrix = Matrix([[3, 2.1], [2, 0]])
        let secondMatrix = Matrix([[5, -2], [4, 1]])
        let result = try! firstMatrix - secondMatrix
        let expectedResult = Matrix([[-2, 4.1], [-2, -1]])
        XCTAssertTrue(result ~= expectedResult)
    }
    
    // MARK: - Multiply Operator
    
    func test_multiply_matrices_2x2_sameType() {
        let firstMatrix = Matrix([[3, 2], [2, 0]])
        let secondMatrix = Matrix([[5, -2], [4, 1]])
        let result = try! firstMatrix * secondMatrix
        let expectedResult = Matrix([[23, -4], [10, -4]])
        XCTAssertTrue(result == expectedResult)
    }
    
    func test_multiply_matrices_3x3_differentTypes() {
        let firstMatrix = Matrix([[9, 8, 7], [3, -2, 0], [0, 2, 5]])
        let secondMatrix = Matrix([[2, 0, -1.3], [3.23, 9, 1], [2, 2.6, 0]])
        let result = try! firstMatrix * secondMatrix
        let expectedResult = Matrix([[57.84, 90.2, -3.7], [-0.46, -18, -5.9], [16.46, 31, 2]])
        XCTAssertTrue(result ~= expectedResult)
    }
    
    func test_multiply_matrices_differentSizes() {
        let firstMatrix = Matrix([[9, 8, 3], [-2, 0, 2]])
        let secondMatrix = Matrix([[2], [0], [-1]])
        let result = try! firstMatrix * secondMatrix
        let expectedResult = Matrix([[15], [-6]])
        XCTAssertTrue(result == expectedResult)
    }
    
    func test_multiply_matrices_inconsistentSizes() {
        let firstMatrix = Matrix([[9, 8], [3, -2], [0, 2]])
        let secondMatrix = Matrix([[2, 0, -1]])
        XCTAssertThrowsError(try firstMatrix * secondMatrix)
    }
    
    // MARK: - Power Operator
    
    func test_power_1x1() {
        XCTAssertEqual(try Matrix([[2]]) ^ 2, Matrix([[4]]))
    }
    
    func test_power_2x2() {
        let matrix = Matrix([[1, 2], [3, 4]])
        let matrixPower = try! matrix ^ 2
        let expectedResult = Matrix([[7, 10], [15, 22]])
        XCTAssertEqual(matrixPower, expectedResult)
    }
    
    func test_3_power_2x2() {
        let matrix = Matrix([[1, 2], [3, 4]])
        let matrixPower = try! matrix ^ 3
        let expectedResult = Matrix([[37, 54], [81, 118]])
        XCTAssertEqual(matrixPower, expectedResult)
    }
    
    func test_power_3x2_inconsistentSize() {
        XCTAssertThrowsError(try Matrix([[1, 2], [2, 3], [3, 4]]) ^ 2)
    }
    
    func test_power_3x3() {
        let matrix = Matrix([[1, 2, 1], [6, -1, 0], [-1, -2, -1]])
        let matrixPower = try! matrix ^ 2
        let expectedResult = Matrix([[12, -2, 0], [0, 13, 6], [-12, 2, 0]])
        XCTAssertEqual(matrixPower, expectedResult)
    }
}


