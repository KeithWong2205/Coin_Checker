//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didFetchSuccess(_ coinManager: CoinManager, rate: RateModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "77F1919D-D057-4B56-BF7C-5E0F88C217DE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let finalRate = self.parseJSON(safeData){
                        self.delegate?.didFetchSuccess(self, rate: finalRate)
                    }
                }
            }
            task.resume()
        }
    }
            
    func parseJSON(_ rateData: Data) -> RateModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RateData.self, from: rateData)
            let exchangeRate = decodedData.rate
            let base = decodedData.asset_id_base
            let quote = decodedData.asset_id_quote
            
            let rate = RateModel(exchangeRate: exchangeRate, baseCoin: base, quoteCurrency: quote)
            return rate
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
