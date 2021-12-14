//
//  ApplicantListView.swift
//  ApplicantListView
//
//  Created by Justin on 12/13/21.
//

import SwiftUI

struct ApplicantListView: View {
    @EnvironmentObject var applicantViewModel: ApplicantViewModel

    var body: some View {
        VStack {
            List {
                ForEach(applicantViewModel.applicants.indices, id: \.self) { index in
                    NavigationLink(applicantViewModel.applicants[index].name) {
                        ApplicantView(applicant: applicantViewModel.applicants[index])
                            .environmentObject(applicantViewModel)
                    }
                }
                .onDelete(perform: delete)
            }
            .toolbar {
                EditButton()
            }
            
            NavigationLink("Add Applicant") {
                AddApplicant().environmentObject(applicantViewModel)
            }
        }
        .navigationTitle("Applicants")
    }

    func delete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let record = applicantViewModel.applicants[index]
            applicantViewModel.deleteApplicant(record: record)
        }
    }
}

struct ApplicantListView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicantListView()
    }
}
