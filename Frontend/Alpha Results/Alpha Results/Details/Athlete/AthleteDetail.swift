//
//  AthleteDetail.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/17/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteDetail: View {
    @EnvironmentObject var userData: UserData
    @State var athlete: AthleteSchool
    @State var index: Int = 0
    
    var body: some View {
        VStack{
            AthleteDetailHeader(athlete: self.athlete)
            Picker(selection: self.$index.animation(.spring(response: 0.55, dampingFraction: 1, blendDuration: 0)), label: Text(""),content: {
                Text("All Results").tag(0)
                Text("Season Bests").tag(1)
                Text("Rankings").tag(2)
            })
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            LabeledScroll(index: $index, pages:
                [
                    AthleteInfo(id: 0, dataIndex: "Results"),
                    AthleteInfo(id: 1, dataIndex: "Records"),
                    AthleteInfo(id: 2, dataIndex: "Rankings")
                ]
            ).environmentObject(self.userData)
        }
        .navigationBarTitle("Athlete", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {}, label: {Image(systemName: "bookmark")}))
    }
}

struct AthleteDetail_Previews: PreviewProvider {
    static var previews: some View {
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteDetail(athlete: temp)
    }
}


