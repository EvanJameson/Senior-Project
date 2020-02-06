//
//  Meet.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/5/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Meet: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let day: String
    let sport: String
    
    enum CodingKeys: String, CodingKey{
        case id = "MeetID"
        case name = "Name"
        case day = "Day"
        case sport = "Sport"
    }
}
