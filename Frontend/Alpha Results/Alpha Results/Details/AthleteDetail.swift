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
        //NavigationView{
            List{
                AthleteDetailHeader(athlete: athlete)
                
                Text("Personal Records")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top)
                
                    .navigationBarTitle(athlete.aname)
                    .navigationBarItems(trailing: Button(action: {}, label: {Image(systemName: "bookmark")}))
            }
        
        //}
        
    }
}

struct AthleteDetail_Previews: PreviewProvider {
    static var previews: some View {
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteDetail(athlete: temp)
    }
}
