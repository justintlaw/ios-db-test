//
//  AddApplicant.swift
//  AddApplicant
//
//  Created by Justin on 12/13/21.
//

import SwiftUI

struct AddApplicant: View {
//    @State var name = ""
//    @State var age = 0
//    @State var email = ""
    @EnvironmentObject var applicantViewModel: ApplicantViewModel
    @State var name = ""
    @State var age = 1
    @State var email = ""
    
    var body: some View {
        VStack {
            Form {
                VStack {
                    Section(header: Text("Enter Applicant Info")) {
                        TextField("Name", text: $name)
                        HStack {
                            Stepper("Age: \(age)", value: $age, in: 0...130, step: 1)
                        }
                        TextField("Email", text: $email)
                    }
                }
                .padding()
            }
            
            HStack {
                Button(action: {
                    let applicant = Applicant(name: name, age: age, email: email)
                    applicantViewModel.insertApplicant(record: applicant)
                    
                    name = ""
                    age = 1
                    email = ""
                }, label: {
                    Text("Save")
                        .font(.title)
                })
            }
            .padding()
            
            Spacer()
        }
        .navigationBarTitle("Add Applicant")
    }
}

struct AddApplicant_Previews: PreviewProvider {
    static var previews: some View {
        AddApplicant()
    }
}
