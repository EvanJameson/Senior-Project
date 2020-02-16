//
//  AthleteDetailHeader.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/18/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteDetailHeader: View {
    
    @State var athlete: AthleteSchool
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
               
                Text(athlete.city + ", " + athlete.state)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                HStack{
                    Text(athlete.aname)
                    .font(.title)
                    .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(athlete.grade)
                    .font(.title)
                    .fontWeight(.bold)
                }
                    NavigationLink(destination: SchoolDetail(school: School(id: athlete.sid, name: athlete.sname, mascot: athlete.mascot, city: athlete.city, state: athlete.state))){
                        
                            VStack(alignment: .leading){
                                Text(athlete.sname)
                                Text(athlete.mascot)
                            }
                    }
            }
            Spacer()
        }
        .padding(.top)
        .padding(.leading)
    }
}

struct AthleteDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteDetailHeader(athlete: temp)
    }
}
