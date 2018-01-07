//
//  ModelInfo.swift
//  Run
//
//  Created by Vahagn Gevorgyan on 1/7/18.
//

import Vapor
import FluentProvider
import HTTP

final class Pet: Model {
    var name: String
    var age: Int
    let storage = Storage()
    
    init(row: Row) throws {
        name = try row.get("name")
        age = try row.get("age")
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        try row.set("age", age)
        return row
    }
}

extension Pet: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self) { pets in
            pets.id()
            pets.string("name")
            pets.int("age")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
