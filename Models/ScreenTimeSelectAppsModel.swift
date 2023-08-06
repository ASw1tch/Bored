//
//  ScreenTimeSelectAppsModel.swift
//  Bored
//
//  Created by user1 on 06.08.2023.
//

import Foundation
import FamilyControls

class ScreenTimeSelectAppsModel: ObservableObject {
    @Published var activitySelection = FamilyActivitySelection()

    init() { }
}

