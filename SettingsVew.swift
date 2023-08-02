//
//  SettingsVew.swift
//  Bored
//
//  Created by user1 on 21.07.2023.
//

import SwiftUI



struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var accessibility: Double
    @Binding var type: String
    @Binding var participants: Int
    @Binding var price: String
    
    
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
                        .mask(Slider(value: $accessibility, in: 0.1...1.0, step: 0.1))
                        
                        Slider(value: $accessibility, in: 0.1...1.0, step: 0.1)
                        
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
                    Picker(selection: $type, label: (Text("Type"))) {
                        ForEach(["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"], id: \.self) { type in
                            Text(type).tag(type)
                        }
                    }.frame(height: 150)
                        .pickerStyle(WheelPickerStyle())
                } header: {
                    Text("Type")
                } footer: {
                    Text("Select the type of assignments you'll receive")
                }
                
                
                Section() {
                    Stepper(value: $participants, in: 1...10) {
                        Text("\(participants)")
                    }
                }header: {
                    Text("Participants")
                } footer: {
                    Text("How many people will take part")
                }
                
                
                Section() {
                    Picker(selection: $price ,label: Text("Price")) {
                        ForEach(["Free", "Paid"], id: \.self) { price in
                            Text(price).tag(price)
                        }
                    }
                } header: {
                    Text("Price")
                } footer: {
                    Text("Acntivity cost")
                }
                
                Button ("Done") {
                    print(accessibility)
                    print(type)
                    print(participants)
                    print(price)
                    self.presentationMode.wrappedValue.dismiss()
                }.frame(width: 320, height: 50)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .bold()
            }.pickerStyle(SegmentedPickerStyle())
            
            
            
        }
    }
}


struct SettingsView_Previews:PreviewProvider {
    static var previews: some View {
        SettingsView(accessibility: .constant(0.5),
                     type: .constant("Educational"),
                     participants: .constant(1),
                     price: .constant("Free"))
    }
}



