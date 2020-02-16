//
//  MeetDetailHeader.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/15/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct MeetDetailHeader: View {
    
    @State var meet: Meet
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
               
                Text(meet.day)// + ", " + school.state)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(meet.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text("Sccc")
                    .font(.subheadline)
                        
            }
            Spacer()
        }
        .padding(.top)
        .padding(.leading)
        
    }
}
