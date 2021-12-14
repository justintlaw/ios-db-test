//
//  ApplicantDatabase.swift
//  ApplicantDatabase
//
//  Created by Justin on 12/13/21.
//

import Foundation
import GRDB

class ApplicantDatabase {
    // MARK: Constants
    struct Constant {
        static let fileName = "applicant.21"
        static let fileExtension = "sqlite"
    }
    
    // MARK: - Properties

    var dbQueue: DatabaseQueue

    // MARK: - Singleton

    static let shared = ApplicantDatabase()
    
    private init() {
        if let path = Bundle.main.path(forResource: Constant.fileName,
                                       ofType: Constant.fileExtension) {
            if let queue = try? DatabaseQueue(path: path) {
                dbQueue = queue
                return
            }
        }

        fatalError("Unable to connect to database")
    }

    
    // MARK: Migrations
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()

        migrator.registerMigration("createProject") { db in
            try db.create(table: "applicant", ifNotExists: true) { t in
//                t.autoIncrementedPrimaryKey("id")
                t.primaryKey(["id"])
                t.column("name", .text).notNull()
                t.column("age", .numeric)
                t.column("email", .text).notNull()
            }
        }

        return migrator
    }

}
