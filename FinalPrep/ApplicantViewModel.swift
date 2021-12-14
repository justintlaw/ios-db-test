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
        }
    }
    
    func insertApplicant(record: Applicant) {
        DatabaseHelper.shared.insertApplicant(record)
        
        applicants.append(record)
    }
    
    func updateApplicant(record: Applicant) {
        DatabaseHelper.shared.updateApplicant(record)
        
        if let index = applicants.firstIndex(of: record) {
            applicants[index] = record
        }
    }
    
    static func getApplicants() -> [Applicant] {
        return DatabaseHelper.shared.getApplicants()
    }
    
    static func getApplicant(id: String) -> Applicant {
        return DatabaseHelper.shared.getApplicant(id: id)
    }
}
