//
//  SchoolInfo.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/15/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SchoolInfo: View, Identifiable {

    var id: Int
    
    @State var dataIndex: String = ""
    
    var body: some View {
        VStack{
            if(self.dataIndex == "Meets"){
                SchoolMeets()
            }
            else if(dataIndex == "Records"){
                SchoolRecords()
            }
            else if(dataIndex == "More"){
                SchoolMore()
            }
        }
    }
}

struct SchoolMeets: View {
    var body: some View {
        Text("Meets")
    }
}

struct SchoolRecords: View {
    var body: some View {
        Text("Records")
    }
}

struct SchoolMore: View {
    var body: some View {
        Text("More")
    }
}

