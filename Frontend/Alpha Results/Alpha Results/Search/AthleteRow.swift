//
//  AthleteRow.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteRow: View {
    let athlete: AthleteSchool
    let tfColor = Color(UIColor(red: 14/255, green: 0/255, blue: 170/255, alpha: 1.0))
    let xcColor = Color(UIColor(red: 0/255, green: 137/255, blue: 22/255, alpha: 1.0))
    
    var body: some View {
        HStack{
            //Make this some random generated color thing
            CircleImage(image: Image(athlete.sname.lowercased()), wh: 50)
                .padding(.leading, -7)
            
            //placeholder icons to add some color
            Text("TF")
                .fontWeight(.bold)
                .foregroundColor(tfColor)
            Text("XC")
                .fontWeight(.bold)
                .foregroundColor(xcColor)
            Spacer()
            VStack(alignment: .trailing){
                Text(athlete.aname)
                    .fontWeight(.bold)
                Spacer()
                Text(athlete.sname)
            }
        }
    .padding()
    }
}

struct AthleteRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AthleteRow(athlete: AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "12", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA"))
                .previewLayout(.fixed(width: 300, height: 80))
                .environment(\.colorScheme, .light)
        
        }
    }
}
