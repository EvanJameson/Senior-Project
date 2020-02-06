//
//  AthleteDetailHeader.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/18/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteDetailHeader: View {
    
    @State var athlete: Athlete
    
    var body: some View {
        HStack {
            //CircleImage(image: Image(athlete.school.lowercased()), wh: 100)

            
            VStack {
                HStack {
                    Spacer()
                    Text(athlete.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
                HStack {
                    Text(athlete.grade)
                    Spacer()
                    //Text(athlete.school)
                }
                .padding()
                    
            }
        }
    }
}

struct AthleteDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        let temp = Athlete(id: 0, name: "Evan Jameson", gender: "Male", grade: "SR")
        
        return AthleteDetailHeader(athlete: temp)
    }
}
