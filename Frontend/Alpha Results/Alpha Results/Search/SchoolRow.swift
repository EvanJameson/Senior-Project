//
//  SchoolRow.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SchoolRow: View {
    let school: School

    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(school.name)
                    .fontWeight(.bold)
                Spacer()
                Text(school.mascot)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text(school.city)
                    
                Spacer()
                Text(school.state)
                .fontWeight(.bold)
            }
        }
    .padding()
    }
}

struct SchoolRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SchoolRow(school: School(id: 0, name: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA"))
                .previewLayout(.fixed(width: 300, height: 80))
                .environment(\.colorScheme, .light)
        
        }
    }
}
