//
//  Athlete.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/17/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI
// Hashable ?
struct Wrapper: Codable, Hashable {
    //let id: Int
    
    let athletes: [Athlete]
}

struct Athlete: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let gender: String
    let grade: String
    
    enum CodingKeys: String, CodingKey{
        case id = "AthleteID"
        case name = "Name"
        case gender = "Gender"
        case grade = "Grade"
    }
}

//struct track: Codable, Hashable {
//    let records: String //Placeholder
//    let results: String //Placeholder
//
//    enum CodingKeys: String, CodingKey{
//        case records = "Records"
//        case results = "Results"
//    }
//}
//
//struct cross: Codable, Hashable {
//    let records: String //Placeholder
//    let results: String //Placeholder
//
//    enum CodingKeys: String, CodingKey{
//        case records = "Records"
//        case results = "Results"
//    }
//}
