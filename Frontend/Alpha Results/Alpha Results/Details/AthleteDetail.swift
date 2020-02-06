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
    
    var body: some View {
        TabView {
            VStack{
                AthleteDetailHeader(athlete: athlete)//wont slide up with list...
                List{
                    
                    Text("Test 1")
                }
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
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteDetail(athlete: temp)
    }
}
