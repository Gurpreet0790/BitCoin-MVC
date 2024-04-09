//
//  CoinModel.swift
//  BitCoin
//
//  Created by ReetDhillon on 2024-04-08.
//

import Foundation

struct CoinModel {
    let currencyRate: Double
    var currencyRateString: String{
        return String(format: "%.2f", currencyRate)
    }
}
