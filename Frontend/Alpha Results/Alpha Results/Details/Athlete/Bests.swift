//
//  Bests.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/16/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Bests:  Identifiable, Hashable {
    let id: Int
    let event: String
    let season: String
    let grade: String
    let mark: String
    let pr: String
}
