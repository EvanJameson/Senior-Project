//
//  AthleteDetail.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/17/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI



struct AthleteDetail: View {
    
    @State var athlete: Athlete
    
    var body: some View {
        TabView {
            List{
                AthleteDetailHeader(athlete: athlete)
                Text("Test 1")
            }
            .tabItem { Text("Track & Field") }.tag(1)
            List{
                AthleteDetailHeader(athlete: athlete)
                Text("Test 2")
            }
            .tabItem { Text("Cross Country") }.tag(2)
        }
    }
}

struct AthleteDetail_Previews: PreviewProvider {
    static var previews: some View {
        let temp = Athlete(tf: nil, xc: nil, name: "Evan Jameson", school: "CPSLO", grade: "SR")
        
        return AthleteDetail(athlete: temp)
    }
}
