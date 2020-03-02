//
//  ObservableHolder.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/23/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

class ObservableHolder: ObservableObject {
    @Published var holder = ResultsHolder(id: 0)
}
