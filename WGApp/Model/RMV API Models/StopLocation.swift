//
//  StopLocation.swift
//  WGApp
//
//  Created by Viviane Rehor on 31.05.18.
//  Copyright © 2018 Viviane Rehor. All rights reserved.
//

import Foundation

struct StopLocation: Codable {
    var id: String
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "extId"
        case name
    }
}
