//
//  MatrixTests.swift
//  MatrixTests
//
//  Created by Dmytro Durda on 11/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import XCTest
@testable import Matrix

class MatrixTests: XCTestCase {

    func test_createEmptyMatrix() {
        let emptyMatrix = Matrix<Bool>()
        
        XCTAssertEqual(emptyMatrix.rows, 0)
        XCTAssertEqual(emptyMatrix.columns, 0)
        XCTAssertEqual(emptyMatrix.grid, [])
        XCTAssertEqual(emptyMatrix.grid, [Bool]())
    }
    
    func test_createEmptyMatrix_WithRepeatedValue() {
        let emptyMatrix = Matrix(rows: 0, columns: 0, repeating: true)
        
        XCTAssertEqual(emptyMatrix.rows, 0)
        XCTAssertEqual(emptyMatrix.columns, 0)
        XCTAssertEqual(emptyMatrix.grid, [])
        XCTAssertEqual(emptyMatrix.grid, [Bool]())
    }
    
    func test_createMatrix_2x3() {
        let matrix = Matrix(rows: 2, columns: 2, repeating: true)
        let grid = [true, true, true, true]
        
        XCTAssertEqual(matrix.grid, grid)
    }
    
    func test_createMatrix_usingRowVector() {
        let matrix = Matrix(rowVector: [2, 5])
        
        XCTAssertEqual(matrix.grid, [2, 5])
        XCTAssertEqual(matrix[0, 0], 2)
        XCTAssertEqual(matrix[0, 1], 5)
    }
    
    func test_createMatrix_usingColumnVector() {
        let matrix = Matrix(columnVector: [2, 5])
        
        XCTAssertEqual(matrix.grid, [2, 5])
        XCTAssertEqual(matrix[0, 0], 2)
        XCTAssertEqual(matrix[1, 0], 5)
    }
    
    func test_getVectors() {
        let matrix = Matrix([[1, 2], [3, 4]])
        
        XCTAssertEqual(matrix.rowVectors, [[1, 2], [3, 4]])
        XCTAssertEqual(matrix.columnVectors, [[1, 3], [2, 4]])
    }
    
    func test_compareIndices() {
        let index1 = MatrixIndex(row: 1, column: 1)
        let index2 = MatrixIndex(row: 1, column: 2)
        
        XCTAssertTrue(index1 < index2)
    }
}
