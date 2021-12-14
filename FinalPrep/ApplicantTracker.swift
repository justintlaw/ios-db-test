//
//  ApplicantTracker.swift
//  FinalPrep
//
//  Created by Justin on 12/13/21.
//

import SwiftUI

struct ApplicantTracker: View {
    var body: some View {
        NavigationView {
            ApplicantListView().environmentObject(ApplicantViewModel())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ApplicantTracker_Previews: PreviewProvider {
    static var previews: some View {
        ApplicantTracker()
    }
}
