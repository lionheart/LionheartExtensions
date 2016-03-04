//
//  FMDB.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 3/4/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import FMDB

extension FMDatabase {
    func createIfNeeded() {
        open()
        close()
    }

    func executeUpdateFromFile(file: File) -> Bool {
        if let sql = file.read() {
            return executeStatements(sql)
        }
        else {
            return false
        }
    }

    func executeMultilineUpdate(sql: String...) -> Bool {
        return executeUpdate(sql.joinWithSeparator("\n"))
    }

    func executeUpdate(sql: String, VAList: AnyObject...) -> Bool {
        return executeUpdate(sql, withArgumentsInArray: VAList)
    }

    func executeQuery(sql: String, VAList: AnyObject...) -> FMResultSet {
        return executeQuery(sql, withArgumentsInArray: VAList)
    }
}

public struct FMResultSetGenerator: GeneratorType {
    /**
    */
    public typealias Element = FMResultSet
    var resultSet: FMResultSet

    init(resultSet: FMResultSet) {
        self.resultSet = resultSet
    }

    public mutating func next() -> Element? {
        let success = resultSet.next()
        if success {
            return resultSet
        }
        else {
            return nil
        }
    }
}

extension FMResultSet: SequenceType {
    public typealias Generator = FMResultSetGenerator

    public func generate() -> Generator {
        return FMResultSetGenerator(resultSet: self)
    }
}
