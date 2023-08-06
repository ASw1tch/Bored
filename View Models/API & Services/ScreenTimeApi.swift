//
//  ScreenTimeApi.swift
//  Bored
//
//  Created by user1 on 06.08.2023.
//

import FamilyControls
import SwiftUI

struct ScreenTimeApi {
    let ac = AuthorizationCenter.shared
       
       func requestAuthorization() async {
           do {
               try await ac.requestAuthorization(for: .individual)
               print("Access to device activity granted.")
           } catch {
               print("Error requesting authorization: \(error.localizedDescription)")
           }
       }
}


