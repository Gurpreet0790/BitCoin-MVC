//
//  CoinData.swift
//  BitCoin
//
//  Created by ReetDhillon on 2024-04-08.
//

import Foundation

struct CoinData: Codable {
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
