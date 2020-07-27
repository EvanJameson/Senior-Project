//
//  Record.swift
//  Alpha Results
//
//  Created by Evan Jameson on 3/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Record:  Codable, Identifiable, Hashable {
    let id: Int
    let time: String
    let mark: String
    let seasonYear: String
    let event: String
    
    enum CodingKeys: String, CodingKey{
        case id = "ResultID"
        case time = "TimeMark"
        case mark = "MarkString"
        case seasonYear = "SeasonYear"
        case event = "EventName"
    }
}
