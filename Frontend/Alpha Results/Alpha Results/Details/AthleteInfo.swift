//
//  AthleteInfo.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/14/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteInfo: View, Identifiable {

    var id: Int
    
    @State var dataIndex: String = ""
    
    var body: some View {
        VStack{
            if(self.dataIndex == "Results"){
                AthleteResults()
            }
            else if(dataIndex == "Records"){
                AthleteRecords()
            }
            else if(dataIndex == "Rankings"){
                AthleteRankings()
            }
        }
    }
}

struct AthleteResults: View {
    var body: some View {
        Text("1")
    }
}

struct AthleteRecords: View {
    var body: some View {
        Text("2")
    }
}

struct AthleteRankings: View {
    var body: some View {
        Text("3")
    }
}

struct AthleteInfo_Previews: PreviewProvider {
    static var previews: some View {
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteInfo(id: 0, dataIndex: "Results")
    }
}
