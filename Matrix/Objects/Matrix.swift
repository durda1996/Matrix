//
//  Matrix.swift
//  Matrix
//
//  Created by Dmytro Durda on 11/10/2019.
//  Copyright © 2019 Star. All rights reserved.
//

import Foundation

struct Matrix<Element: Equatable> {
    private(set) var rows: Int
    private(set) var columns: Int
    private(set) var grid: [Element]
    
    // MARK: - Init
    
    init() {
        self.rows = 0
        self.columns = 0
        self.grid = []
    }
    
    init(rows: Int, columns: Int, repeating repeatedValue: Element) {
        guard rows >= .zero && columns >= .zero else {
            fatalError("Can't construct Matrix with rows and columns count < 0")
        }
        
        if rows == .zero || columns == .zero {
            self.rows = 0
            self.columns = 0
            self.grid = []
            return
        }
        
        self.rows = rows
        self.columns = columns
        self.grid = Array(repeating: repeatedValue, count: rows * columns)
    }
    
    init(rows: Int, columns: Int, grid: [Element]) {
        guard rows * columns == grid.count else {
            fatalError("Matrix length must be the same as grid elements count")
        }
        
        self.rows = rows
        self.columns = columns
        self.grid = grid
    }
    
    init(_ data: [[Element]]) {
        guard data.allSatisfy({ $0.count == data.first?.count }) else {
            fatalError("All rows must have the same count of items")
        }
        
        self.rows = data.count
        self.columns = data.first?.count ?? 0
        self.grid = []
        data.forEach { self.grid.append(contentsOf: $0) }
    }
    
    init(rowVector: [Element]) {
        self.rows = 1
        self.columns = rowVector.count
        self.grid = rowVector
    }
    
    init(columnVector: [Element]) {
        self.rows = columnVector.count
        self.columns = 1
        self.grid = columnVector
    }
    
    // MARK: - Subscript
    
    subscript(row: Int, column: Int) -> Element {
        get {
            guard indexIsValid(row: row, column: column) else {
                fatalError("Index out of range")
            }
            
            return grid[(row * columns) + column]
        }
        set {
            guard indexIsValid(row: row, column: column) else {
                fatalError("Index out of range")
            }
            
            grid[(row * columns) + column] = newValue
        }
    }
    
    subscript(index: MatrixIndex) -> Element {
        get {
            guard indexIsValid(index) else {
                fatalError("Index out of range")
            }
            
            return grid[(index.row * columns) + index.column]
        }
        set {
            guard indexIsValid(index) else {
                fatalError("Index out of range")
            }
            
            grid[(index.row * columns) + index.column] = newValue
        }
    }
    
    // MARK: - Accessors
    
    var first: Element? {
        if indexIsValid(startIndex) {
            return self[startIndex]
        }
        
        return nil
    }
    
    var last: Element? {
        if indexIsValid(endIndex) {
            return self[endIndex]
        }
        
        return nil
    }
    
    func first(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        return try grid.first(where: predicate)
    }
    
    func last(where predicate: (Element) throws -> Bool) rethrows -> Element? {
        return try grid.last(where: predicate)
    }
    
    func enumerated() -> EnumeratedMatrix<Element> {
        return EnumeratedMatrix(self)
    }
    
    func reversed() -> Self {
        var matrix = self
        matrix.reverse()
        return matrix
    }
    
    mutating func reverse() {
        grid.reverse()
    }
    
    mutating func swapAt(_ firstIndex: MatrixIndex, _ secondIndex: MatrixIndex) {
        let firstValue = self[firstIndex]
        let secondValue = self[secondIndex]
        
        self[firstIndex] = secondValue
        self[secondIndex] = firstValue
    }
    
    mutating func swapRowVectorsAt(_ firstRow: Int, _ secondRow: Int) {
        for column in 0..<columns {
            let firstIndex = MatrixIndex(row: firstRow, column: column)
            let secondIndex = MatrixIndex(row: secondRow, column: column)
            
            let firstValue = self[firstIndex]
            let secondValue = self[secondIndex]
            
            self[firstIndex] = secondValue
            self[secondIndex] = firstValue
        }
    }
    
    mutating func swapColumnVectorsAt(_ firstColumn: Int, _ secondColumn: Int) {
        for row in 0..<rows {
            let firstIndex = MatrixIndex(row: row, column: firstColumn)
            let secondIndex = MatrixIndex(row: row, column: secondColumn)
            
            let firstValue = self[firstIndex]
            let secondValue = self[secondIndex]
            
            self[firstIndex] = secondValue
            self[secondIndex] = firstValue
        }
    }
    
    // MARK: - Index
    
    private func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    private func indexIsValid(_ index: MatrixIndex) -> Bool {
        return indexIsValid(row: index.row, column: index.column)
    }
    
    var startIndex: MatrixIndex {
        return MatrixIndex(row: 0, column: 0)
    }
    
    var endIndex: MatrixIndex {
        return MatrixIndex(row: rows, column: columns)
    }
    
    var indices: [MatrixIndex] {
        var indices = [MatrixIndex]()
        
        for row in 0..<rows {
            for column in 0..<columns {
                indices.append(MatrixIndex(row: row, column: column))
            }
        }
        
        return indices
    }
    
    func indices(for value: Element) -> [MatrixIndex] {
        return indices.filter({ self[$0] == value })
    }

    func firstIndex(of value: Element) -> MatrixIndex? {
        for (offset, element) in self.enumerated() {
            if value == element {
                return offset
            }
        }
        
        return nil
    }

    func firstIndex(where predicate: (Element) throws -> Bool) rethrows -> MatrixIndex? {
        for (offset, element) in self.enumerated() {
            if try predicate(element) {
                return offset
            }
        }
        
        return nil
    }

    func lastIndex(of value: Element) -> MatrixIndex? {
        for (offset, element) in self.reversed().enumerated() {
            if value == element {
                return offset
            }
        }
        
        return nil
    }

    func lastIndex(where predicate: (Element) throws -> Bool) rethrows -> MatrixIndex? {
        for (offset, element) in self.reversed().enumerated() {
            if try predicate(element) {
                return offset
            }
        }
        
        return nil
    }
    
    // MARK: - Vectors
    
    var rowVectors: [[Element]] {
        var rowVectors = [[Element]]()
        
        for row in 0..<rows {
            var rowVector = [Element]()
            
            for column in 0..<columns {
                rowVector.append(self[row, column])
            }
            
            rowVectors.append(rowVector)
        }
        
        return rowVectors
    }
    
    var columnVectors: [[Element]] {
        var columnVectors = [[Element]]()
        
        for column in 0..<columns {
            var columnVector = [Element]()
            
            for row in 0..<rows {
                columnVector.append(self[row, column])
            }
            
            columnVectors.append(columnVector)
        }
        
        return columnVectors
    }
    
    func rowVector(at row: Int) -> [Element] {
        return rowVectors[row]
    }
    
    func columnVector(at column: Int) -> [Element] {
        return columnVectors[column]
    }
    
    mutating func append(rowVector: [Element]) {
        if columns == 0 {
            columns = rowVector.count
        }
        
        guard rowVector.count == columns else {
            fatalError("Can't append row vector with items count differs from columns count")
        }
        
        grid.append(contentsOf: rowVector)
        rows += 1
    }
    
    mutating func append(columnVector: [Element]) {
        if rows == 0 {
            rows = columnVector.count
        }
        
        guard columnVector.count == rows else {
            fatalError("Can't append column vector with items count differs from rows count")
        }
        
        columns += 1
        
        for (offset, value) in columnVector.enumerated() {
            grid.insert(value, at: (offset * columns) + columns - 1)
        }
    }
    
    // Remove
    
    mutating func removeFirstRowVector() {
        guard !grid.isEmpty else {
            fatalError("Can't remove first row vector from an empty matrix")
        }
        
        removeRowVector(at: 0)
    }
    
    mutating func removeLastRowVector() {
        guard !grid.isEmpty else {
            fatalError("Can't remove last row vector from an empty matrix")
        }
        
        removeRowVector(at: rows)
    }
    
    mutating func removeRowVector(at rowIndex: Int) {
        guard rowIndex >= 0 && rowIndex < rows else {
            fatalError("Row index out of range")
        }
        
        for column in (0..<columns).reversed() {
            grid.remove(at: (rowIndex * columns) + column)
        }
        
        rows -= 1
    }
    
    mutating func removeFirstColumnVector() {
        guard !grid.isEmpty else {
            fatalError("Can't remove first column vector from an empty matrix")
        }
        
        removeColumnVector(at: 0)
    }
    
    mutating func removeLastColumnVector() {
        guard !grid.isEmpty else {
            fatalError("Can't remove last column vector from an empty matrix")
        }
        
        removeColumnVector(at: columns)
    }
    
    mutating func removeColumnVector(at columnIndex: Int) {
        guard columnIndex >= 0 && columnIndex < columns else {
            fatalError("Column index out of range")
        }
        
        for row in (0..<rows).reversed() {
            grid.remove(at: (row * columns) + columnIndex)
        }
        
        columns -= 1
    }
    
    mutating func removeAll() {
        grid.removeAll()
    }
    
    // MARK: - Shuffle
    
    mutating func shuffle() {
        grid.shuffle()
    }
    
    mutating func shuffle<T>(using generator: inout T) where T : RandomNumberGenerator {
        grid.shuffle(using: &generator)
    }
    
    func shufled() -> Self {
        var matrix = self
        matrix.shuffle()
        return matrix
    }
    
    func shuffled<T>(using generator: inout T) -> Self where T : RandomNumberGenerator {
        var matrix = self
        matrix.shuffle(using: &generator)
        return matrix
    }
    
    // MARK: - Closures
    
    func map<T>(_ transform: (Element) throws -> T) rethrows -> Matrix<T> {
        let transformedGrid = try grid.map(transform)
        return Matrix<T>(rows: rows, columns: columns, grid: transformedGrid)
    }
    
    func allSatisfy(_ predicate: (Element) throws -> Bool) rethrows -> Bool {
        return try grid.allSatisfy(predicate)
    }
    
    func forEach(_ body: (Element) throws -> Void) rethrows {
        return try grid.forEach(body)
    }
    
}
