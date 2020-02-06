//
//  AthleteSchool.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteSchool: Codable, Identifiable, Hashable {
    let id: Int
    let aname: String
    let gender: String
    let grade: String
    let sid: Int
    let sname: String
    let mascot: String
    let city: String
    let state: String
    
    enum CodingKeys: String, CodingKey{
        case id = "AthleteID"
        case aname = "AthleteName"
        case gender = "Gender"
        case grade = "Grade"
        case sid = "SchoolID"
        case sname = "SchoolName"
        case mascot = "Mascot"
        case city = "City"
        case state = "State"
    }
}
