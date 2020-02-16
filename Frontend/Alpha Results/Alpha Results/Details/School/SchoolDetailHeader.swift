//
//  SchoolDetailHeader.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/15/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SchoolDetailHeader: View {
    
    @State var school: School
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
               
                Text(school.city + ", " + school.state)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(school.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(school.mascot)
                    .font(.subheadline)
                        
            }
            Spacer()
        }
        .padding(.top)
        .padding(.leading)
        
    }
}
