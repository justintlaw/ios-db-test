//
//  DatabaseHelper.swift
//  DatabaseHelper
//
//  Created by Justin on 12/13/21.
//

import Foundation
import GRDB

typealias ApplicantTable = Applicant.Table
class DatabaseHelper {
    
    // MARK: Constants
    
    struct Constant {
        static let fileName = "applicant.21"
        static let fileExtension = "sqlite"
    }
    
    // MARK: Properties
    
    var dbQueue: DatabaseQueue
    
    // MARK: Singleton
    
    static let shared = DatabaseHelper()
    
    private init() {
        if let directoryUrl = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        ) {
            let fileUrl = directoryUrl
                .appendingPathComponent(Constant.fileName)
                .appendingPathExtension(Constant.fileExtension)
            let fileExists = FileManager.default.fileExists(atPath: fileUrl.path)
            
            if let queue = try? DatabaseQueue(path: fileUrl.path) {
                dbQueue = queue
                
                if !fileExists {
                    // createWorkoutReportTable
                    do {
                        try ApplicantDatabase.migrator.migrate(dbQueue)
                    } catch {
                        fatalError("Failed to create applicant table")
                    }
                }
                
                return
            }
        }
        
        fatalError("Unable to connect to database")
    }
    
    // MARK: CRUD
    
    func deleteApplicant(_ record: Applicant) {
        do {
            try dbQueue.write { db in
                _ = try record.delete(db)
            }
        } catch {
            print("Error deleting record: \(error)")
        }
    }
    
    func insertApplicant(_ record: Applicant) {
        try? dbQueue.write { db in
            try? record.insert(db)
        }
    }
    
    func updateApplicant(_ record: Applicant) {
        try? dbQueue.write { db in
            try? record.update(db)
        }
    }
    
    func getApplicants() -> [Applicant] {
        do {
            let records = try? dbQueue.read { db in
                try Applicant.fetchAll(db)
            }
            
            return records ?? [Applicant]()
        }
    }
    
    func getApplicant(id: String) -> Applicant {
        do {
            let record = try? dbQueue.read { db in
                try Applicant.fetchOne(db, id: id)
            }
            
            return record ?? Applicant()
        }
    }
}
