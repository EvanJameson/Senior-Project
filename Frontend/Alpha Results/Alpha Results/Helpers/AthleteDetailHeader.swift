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
        HStack {
            CircleImage(image: Image(athlete.sname.lowercased()), wh: 100)
            .padding(.leading, 7)

            
            VStack {
                HStack {
                    
                    Text(athlete.aname)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Spacer()
                }
                HStack {
                    Text(athlete.sname)
                    Spacer()
                    Text(athlete.grade)
                    
                    //Spacer()
                    //Text(athlete.school)
                }
                .padding()
                    
            }
        }
    }
}

struct AthleteDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteDetailHeader(athlete: temp)
    }
}
