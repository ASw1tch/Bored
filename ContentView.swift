//
//  ContentView.swift
//  Bored
//
//  Created by user1 on 18.07.2023.
//

import SwiftUI



struct ContentView: View {
    @StateObject private var viewModel = contentViewModel()
    
    @State private var retryParameters = contentViewModel.RetryParameters(participants: 1, selectedPrice: "Free")
    @State private var isButtonPressed = false
    @State private var isSettingsActive = false
    
    @State private var accessibility: Double = 0.1
    @State private var selectedType: String = "social"
    @State private var participants: Int = 1
    @State private var selectedPrice: String = "Free"
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                LinearGradient(colors: [Color.init(hex: "C2DEDC"),
                                        Color.init(hex: "116A7B")],
                               startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
                
                
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        Button(action: {
                            isSettingsActive = true
                        })
                        {
                            Image(systemName: "gearshape")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding(10)
                        .foregroundColor(Color.white)
                        
                        .sheet(isPresented: $isSettingsActive, content: {
                            SettingsView(accessibility: $accessibility,
                                         type: $selectedType,
                                         participants: $participants,
                                         price: $selectedPrice)
                        })
                    }
                    
                    Spacer()
                    
                    
                    Text("Кажется, ты засиделся, занимаясь бессмысленным скролингом...")
                        .padding(15)
                        .font(Font.system(size: 30))
                        .foregroundColor(Color.init(hex: "CDC2AE"))
                        .multilineTextAlignment(.center)
                        .bold()
                    
                    
                    Button("Согласен") {
                        viewModel.fetchDataFromBoredAPI(selectedType: selectedType, participants: participants, selectedPrice: selectedPrice, accessibility: accessibility) { result in
                            switch result {
                            case .success(let apiResponse):
                                DispatchQueue.main.async {
                                    viewModel.activityText = apiResponse.activity
                                    print(accessibility)
                                    print(selectedType)
                                    print(participants)
                                    print(selectedPrice)
                                    print(apiResponse)
                                }
                            case .failure(_):
                                
                                viewModel.fetchDataWithRetry(selectedType: selectedType, retryParameters: retryParameters, accessibility: accessibility, maxRetryCount: 10) { result in
                                    switch result {
                                    case .success(let apiResponse):
                                        viewModel.activityText = apiResponse.activity
                                        
                                        print(apiResponse)
                                    case .failure(let error):
                                        
                                        print("Ooops, \(error)")
                                    }
                                }
                                
                            }
                            withAnimation {
                                isButtonPressed = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                                withAnimation {
                                    isButtonPressed = false
                                }
                            }
                        }
                    }
                    .padding(12)
                    .font(Font.system(size: 20, weight: .black))
                    .background(Color.init(hex: "00C4FF"))
                    .foregroundColor(.white)
                    .cornerRadius(8, antialiased: true)
                    .padding(.bottom, isButtonPressed ? 30 : 0)
                    .scaleEffect(isButtonPressed ? 0.7 : 1.0)
                    .bold()
                    
                    
                    Text(viewModel.activityText)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .onAppear {
                           viewModel.activityText = "Pick an activity and push the button👆🏽"
                        }
                    
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
           
    }
}



extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

