//
//  RateModel.swift
//  ByteCoin
//
//  Created by Keith on 8/10/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct RateModel: Codable{
    var exchangeRate: Double
    var baseCoin: String
    var quoteCurrency: String
}
