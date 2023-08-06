//
//  ScreenTimeSelectAppsContentView.swift
//  Bored
//
//  Created by user1 on 06.08.2023.
//

import SwiftUI
import FamilyControls

struct ScreenTimeSelectAppsContentView: View {

    @State private var pickerIsPresented = false
    @ObservedObject var model: ScreenTimeSelectAppsModel

    var body: some View {
        Button {
            pickerIsPresented = true
        } label: {
            Text("Select Apps")
        }
        .familyActivityPicker(
            isPresented: $pickerIsPresented,
            selection: $model.activitySelection
        )
    }
}
