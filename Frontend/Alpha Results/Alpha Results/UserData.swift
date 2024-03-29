//
//  UserData.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/5/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject, Identifiable {
    @Published var id = 0
    @Published var searchIndex = "Athletes"
    @Published var host = "http://localhost:3000"
    @Published var athleteResults = ResultsHolder(id: 0)

}
