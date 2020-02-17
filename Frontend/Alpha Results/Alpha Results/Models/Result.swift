//
//  Result.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/16/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Result:  Identifiable, Hashable {
    let id: Int
    let position: String
    let event: String
    let season: String
    let date: String
    let mark: String
    let pr: String
    let grade: String
    let meet: String
}
