//
//  SettingsVew.swift
//  Bored
//
//  Created by user1 on 21.07.2023.
//

import SwiftUI

struct Settings {
    var accessibility: Double = 0.5
    var type: String = "Social"
    var participants: Int = 1
    var price: String = "Free"
}


struct SettingsView: View {
    @State var settings: Settings
   
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Settings")
                    .font(.largeTitle)
                    .frame(alignment: .trailing)
                    .bold()
            }
            Form {
                Section() {
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .yellow, .green]),
                            startPoint: .trailing,
                            endPoint: .leading
                        )
                        .mask(Slider(value: $settings.accessibility, in: 0.1...1.0, step: 0.1))
                        
                        Slider(value: $settings.accessibility, in: 0.1...1.0, step: 0.1)
                        
                        //Uncomment it to paint the sliders's circile
                        //.opacity(0.02)
                            .tint(.clear)
                        
                    }
                    
                    
                } header: {
                    Text("Accessibility")
                } footer: {
                    Text("Choose the availability of received tasks")
                }
                
                Section() {
                    Picker(selection: $settings.type, label: (Text("Type"))) {
                        ForEach(["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"], id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }
                } header: {
                    Text("Type")
                } footer: {
                    Text("Select the type of assignments you'll receive")
                }
                .pickerStyle(WheelPickerStyle())
                
                
                Section() {
                    Stepper(value: $settings.participants, in: 1...10) {
                        Text("\(settings.participants)")
                    }
                }header: {
                    Text("Participants")
                } footer: {
                    Text("How many people will take part")
                }
                
                
                Section() {
                    Picker(selection: $settings.price ,label: Text("Price")) {
                        ForEach(["Free", "Paid"], id: \.self) { price in
                            Text(price).tag(price)
                        }
                    }
                } header: {
                    Text("Price")
                } footer: {
                    Text("Acntivity cost")
                }
                
            }.pickerStyle(SegmentedPickerStyle())
            
            
            Section {
                Button ("So") {
                    print(settings.accessibility)
                    print(settings.type)
                    print(settings.participants)
                    print(settings.price )
                }
            }
        }
    }
}



struct SettingsView_Previews:PreviewProvider {
    static var previews: some View {
        SettingsView(settings: (Settings()))
    }
}
