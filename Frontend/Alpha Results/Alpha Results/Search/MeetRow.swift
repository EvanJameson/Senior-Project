//
//  MeetRow.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct MeetRow: View {
    let meet: Meet
    let tfColor = Color(UIColor(red: 14/255, green: 0/255, blue: 170/255, alpha: 1.0))
    let xcColor = Color(UIColor(red: 0/255, green: 137/255, blue: 22/255, alpha: 1.0))
    
    var body: some View {
        HStack{
            //Make this some random generated color thing
//            CircleImage(image: Image(athlete.sname.lowercased()), wh: 50)
//                .padding(.leading, -7)
            
            //sport icon to add some color

            VStack(alignment: .leading){
                Text(meet.name)
                    .fontWeight(.bold)
                Spacer()
                Text(dayFormatter(day: meet.day))
            }
            Spacer()
            if (meet.sport == "TF"){
                Text("TF")
                    .fontWeight(.bold)
                    .foregroundColor(tfColor)
            }
            else if (meet.sport == "XC"){
                Text("XC")
                    .fontWeight(.bold)
                    .foregroundColor(xcColor)
            }
        }
    .padding()
    }
}

struct MeetRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MeetRow(meet: Meet(id: 0, name: "CIF-SDS Finals", day: "2020-01-11", sport: "TF"))
                .previewLayout(.fixed(width: 300, height: 80))
                .environment(\.colorScheme, .light)
        
        }
    }
}

