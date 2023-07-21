//
//  ViewModel.swift
//  Bored
//
//  Created by user1 on 20.07.2023.
//

import Foundation

class contentViewModel: ObservableObject {
    @Published var activityText = ""
    
    func fetchDataFromBoredAPI(completion: @escaping (Result<APIResponse, Error>) -> Void) {
        guard let url = URL(string: "https://www.boredapi.com/api/activity/") else {
            completion(.failure(NSError(domain: "InvalidURL", code: -1, userInfo: nil)))
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
            }
        }.resume()
    }
}
