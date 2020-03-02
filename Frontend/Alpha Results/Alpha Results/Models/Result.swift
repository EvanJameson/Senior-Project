//
//  Result.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/16/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Result:  Codable, Identifiable, Hashable {
    let id: Int
    
    let mid: Int
    let meet: String
    let date: String
    let sport: String
    //let rid: Int
    let position: Int
    let time: String
    let distance: Double
    let pr: Int
    let sr: Int
    let wind: Double
    let season: String
    let handtime: Int
    let converted: Int
    let marktype: String
    let eid: Int
    let event: String
    
    enum CodingKeys: String, CodingKey{
        case id = "ResultID"
        case mid = "MeetID"
        case meet = "MeetName"
        case date = "Day"
        case sport = "Sport"
        //case rid = ""
        case position = "Position"
        case time = "TimeMark"
        case distance = "DistanceMarkInches"
        case pr = "PR"
        case sr = "SR"
        case wind = "Wind"
        case season = "Season"
        case handtime = "HandTime"
        case converted = "Converted"
        case marktype = "MarkType"
        case eid = "EventID"
        case event = "EventName"
    }
}
