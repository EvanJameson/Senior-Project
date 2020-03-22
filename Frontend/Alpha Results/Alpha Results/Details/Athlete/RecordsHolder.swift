//
//  RecordsHolder.swift
//  Alpha Results
//
//  Created by Evan Jameson on 3/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct RecordsHolder: Identifiable, Hashable {
    let id: Int
    var athleteRecords: [Record] = []
    var seasons: [String: [String]] = [:]
    var events: [String] = []
}
