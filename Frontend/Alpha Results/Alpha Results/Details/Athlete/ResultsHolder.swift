//
//  ResultsHolder.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/23/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct ResultsHolder: Identifiable, Hashable {
    let id: Int
    var athleteResults: [Result] = []
    var events: [String] = []
    var seasons: [String] = []
    
}

