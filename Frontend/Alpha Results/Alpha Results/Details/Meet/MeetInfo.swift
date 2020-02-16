//
//  MeetInfo.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/15/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct MeetInfo: View, Identifiable {

    var id: Int
    
    @State var dataIndex: String = ""
    
    var body: some View {
        VStack{
            if(self.dataIndex == "Results"){
                MeetResults()
            }
            else if(dataIndex == "Schools"){
                MeetSchools()
            }
            else if(dataIndex == "Scores"){
                MeetScores()
            }
            else if(dataIndex == "Search"){
                MeetSearch()
            }
        }
    }
}

struct MeetResults: View {
    var body: some View {
        Text("Results")
    }
}

struct MeetSchools: View {
    var body: some View {
        Text("Schools")
    }
}

struct MeetScores: View {
    var body: some View {
        Text("Scores")
    }
}

struct MeetSearch: View {
    var body: some View {
        Text("Search")
    }
}
