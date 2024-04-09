//
//  CoinManager.swift
//  BitCoin
//
//  Created by ReetDhillon on 2024-04-08.
//
import Foundation

protocol CoinManagerDelegate{
    func didUpdateCurrencyConversionRate(_ coinManager: CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error)
}
struct CoinManager{
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "F11A11C0-DB9E-A8F2-2E9F-27D2DE9E6225"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate : CoinManagerDelegate?
    
    func exchangeRate(to currency: String){
        let urlString = "\(baseURL)\(currency)?apiKey=\(apiKey)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {
                data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let currency = self.parseJson(safeData){
                        self.delegate?.didUpdateCurrencyConversionRate(self, coinModel: currency)
                    }
                }
            }
            
            task.resume()
            
        }
    }
    
    func parseJson(_ apiData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData =  try decoder.decode(CoinData.self, from: apiData)
            let currency = decodedData.rate
            
            let coinRate = CoinModel(currencyRate: currency)
            
            return coinRate
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
