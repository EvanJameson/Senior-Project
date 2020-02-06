//
//  School.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/5/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct School: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let mascot: String
    let city: String
    let state: String
    
    enum CodingKeys: String, CodingKey{
        case id = "SchoolID"
        case name = "Name"
        case mascot = "Mascot"
        case city = "City"
        case state = "State"
    }
}
