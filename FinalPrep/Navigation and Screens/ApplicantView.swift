//
//  ApplicantView.swift
//  ApplicantView
//
//  Created by Justin on 12/13/21.
//

import SwiftUI

struct ApplicantView: View {
    @EnvironmentObject var applicantViewModel: ApplicantViewModel
    @State var isEditing = false
    @State var applicant: Applicant
    
    @State var name: String
    @State var age: Int
    @State var email: String
    
    init(applicant: Applicant) {
        self.applicant = applicant

        self.name = applicant.name
        self.age = applicant.age
        self.email = applicant.email
    }

    var body: some View {
        HStack {
            Spacer()
            EditHeader(applicantName: name)
                .padding(.horizontal)
        }
        .navigationBarTitle(applicant.name)

        Form {
            Section(header: Text("Applicant").font(.title2)) {
                TextField("Name", text: $name)
                    .disabled(!isEditing)
                Stepper("Age: \(age)", value: $age, in: 0...130)
                    .disabled(!isEditing)
                TextField("Email", text: $email)
                    .disabled(!isEditing)
            }
        }
        
        if (isEditing) {
            Button(action: {
                applicantViewModel.updateApplicant(record: applicant, name: name, age: age, email: email)

                isEditing = false
            }, label: {
                Text("Save")
                    .font(.title)
            })
        }
    }
    
    @ViewBuilder
    private func EditHeader(applicantName: String) -> some View {
        HStack {
            Spacer()
            Button(action: {
                isEditing.toggle()
            }, label: {
                Text(isEditing ? "Cancel" : "Edit")
            })
        }
    }
}
