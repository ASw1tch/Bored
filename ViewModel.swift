//
//  ViewModel.swift
//  Bored
//
//  Created by user1 on 20.07.2023.
//

import Foundation

class contentViewModel: ObservableObject {
    
    @Published var activityText = ""
    
    func fetchDataFromBoredAPI(selectedType: String, participants: Int, selectedPrice: String, accessibility: Double, completion: @escaping (Result<APIResponse, Error>) -> Void) {
        let priceValue = (selectedPrice == "Free") ? 0 : 1
        let accessibilityValue = String(format: "%.1f", accessibility)
        
        guard let url = URL(string: "https://www.boredapi.com/api/activity?type=\(selectedType)&maxparticipants=\(participants)&price=\(priceValue)&maxaccessibility=\(accessibilityValue)") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
            print()
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            if let error = error {
                completion(.failure(error))
                
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "EmptyResponse", code: -1, userInfo: nil)))
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(error))
                print(url)
            }
        }.resume()
    }
    
    struct RetryParameters {
        var participants: Int
        var selectedPrice: String
    }
    
    func fetchDataWithRetry(selectedType: String, retryParameters: RetryParameters, accessibility: Double, maxRetryCount: Int, currentRetryCount: Int = 0, completion: @escaping (Result<APIResponse, Error>) -> Void) {
        fetchDataFromBoredAPI(selectedType: selectedType, participants: retryParameters.participants, selectedPrice: retryParameters.selectedPrice, accessibility: accessibility) { result in
            switch result {
            case .success(let apiResponse):
                DispatchQueue.main.async {
                    completion(.success(apiResponse))
                }
                
            case .failure(let error):
                if currentRetryCount < maxRetryCount {
                    
                    var updatedRetryParameters = retryParameters
                    updatedRetryParameters.participants += 1
                    updatedRetryParameters.selectedPrice = "Paid"
                    self.fetchDataWithRetry(selectedType: selectedType, retryParameters: updatedRetryParameters, accessibility: accessibility, maxRetryCount: maxRetryCount, currentRetryCount: currentRetryCount + 1, completion: completion)
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}


