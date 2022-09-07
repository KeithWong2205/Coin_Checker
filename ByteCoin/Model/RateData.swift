//
//  RateData.swift
//  ByteCoin
//
//  Created by Keith on 8/10/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct RateData: Decodable{
    var rate: Double
    var asset_id_base: String
    var asset_id_quote: String
}
