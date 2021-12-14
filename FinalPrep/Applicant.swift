//
//  Applicant.swift
//  Applicant
//
//  Created by Justin on 12/13/21.
//

import Foundation
import GRDB

struct Applicant : TableRecord, FetchableRecord, PersistableRecord, Identifiable {
    
    // MARK: Constants

    struct Table {
        static let databaseTableName = "applicant"
        
        static let id = "id"
        static let name = "name"
        static let age = "age"
        static let email = "email"
    }
    
    // MARK: Properties
    
    var id: String
    var name: String
    var age: Int
    var email: String
    
    // MARK: Initializers

    init() {
        id = UUID().uuidString
        name = ""
        age = 1
        email = ""
    }
    
    init(name: String, age: Int, email: String) {
        self.id = UUID().uuidString
        self.name = name
        self.age = age
        self.email = email
    }
    
    init (row: Row) {
        id = row[Table.id]
        name = row[Table.name]
        age = row [Table.age]
        email = row [Table.email]
    }

    // MARK: EncodableRecord
    
    func encode(to container: inout PersistenceContainer) {
        container[Table.id] = id
        container[Table.name] = name
        container[Table.age] = age
        container[Table.email] = email
    }
}

// MARK: Conform to equatable
extension Applicant : Equatable {
    static func ==(lhs: Applicant, rhs: Applicant) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: Conform to hashable
extension Applicant : Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
