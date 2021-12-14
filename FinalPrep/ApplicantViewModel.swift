//
//  ApplicantViewModel.swift
//  ApplicantViewModel
//
//  Created by Justin on 12/13/21.
//

import SwiftUI

class ApplicantViewModel: ObservableObject {
    @Published var applicants: [Applicant]
    
    init() {
        applicants = ApplicantViewModel.getApplicants()
    }
    
    // MARK: CRUD

    func deleteApplicant(record: Applicant) {
        DatabaseHelper.shared.deleteApplicant(record)

        if let index = applicants.firstIndex(of: record) {
            applicants.remove(at: index)
//            objectWillChange.send()
        }
    }
    
    func insertApplicant(record: Applicant) {
        DatabaseHelper.shared.insertApplicant(record)
        
        applicants.append(record)
    }
    
    func updateApplicant(record: Applicant, name: String?, age: Int?, email: String?) {
        var updatedRecord = record

        if let updatedName = name {
            updatedRecord.name = updatedName
        }
        if let updatedAge = age {
            updatedRecord.age = updatedAge
        }
        if let updatedEmail = email {
            updatedRecord.email = updatedEmail
        }

        DatabaseHelper.shared.updateApplicant(updatedRecord)
        
        if let index = applicants.firstIndex(of: updatedRecord) {
            applicants[index] = updatedRecord
        }
    }
    
    static func getApplicants() -> [Applicant] {
        return DatabaseHelper.shared.getApplicants()
    }
    
    static func getApplicant(id: String) -> Applicant {
        return DatabaseHelper.shared.getApplicant(id: id)
    }
}
