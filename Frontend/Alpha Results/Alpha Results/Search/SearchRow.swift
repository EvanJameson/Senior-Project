//
//  SearchRow.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/15/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SearchRow: View {
    let athlete: Athlete
    let tfColor = Color(UIColor(red: 14/255, green: 0/255, blue: 170/255, alpha: 1.0))
    let xcColor = Color(UIColor(red: 0/255, green: 137/255, blue: 22/255, alpha: 1.0))
    
    var body: some View {
        HStack{
            //CircleImage(image: Image(athlete.school.lowercased()), wh: 50)
                //.padding(.leading, -7)
            
            //placeholder icons to add some color
            Text("TF")
                .fontWeight(.bold)
                .foregroundColor(tfColor)
            Text("XC")
                .fontWeight(.bold)
                .foregroundColor(xcColor)
            Spacer()
            VStack(alignment: .trailing){
                Text(athlete.name)
                    .fontWeight(.bold)
                Spacer()
                //Text(athlete.school)
            }
        }
    .padding()
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchRow(athlete: Athlete(id: 0, name: "Evan Jameson", gender: "Male", grade: "12"))
                .previewLayout(.fixed(width: 300, height: 80))
                .environment(\.colorScheme, .light)
            
//            SearchRow(athlete: Athlete(tf: nil, xc: nil, name: "Evan Jameson", school: "CPSLO", grade: "12"))
//                .previewLayout(.fixed(width: 300, height: 80))
                //.environment(\.colorScheme, .dark) ??
        }
    }
}
