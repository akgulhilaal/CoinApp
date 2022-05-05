//
//  CoinRequest.swift
//  CoinApp
//
//  Created by Hilal Akgül on 17.03.2022.
//

import Foundation

enum CoinRequestError: Error {
    case noDataAvailable
    case canNotProcessData
}
struct CoinRequest {
    
    let resourceURL: URL
    
    init() {
        let resourceString = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
        guard let resourceURL = URL(string: resourceString) else {
            fatalError("Error")
        }
        self.resourceURL = resourceURL
    }
    func getCoins(completion : @escaping(Result<[CoinElement],CoinRequestError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, response, error in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let coin = try decoder.decode(CoinDataModel.self, from: jsonData)
                completion(.success(coin.data.coins))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}

