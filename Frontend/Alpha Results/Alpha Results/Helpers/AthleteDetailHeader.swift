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
        VStack(){
            HStack{
                Text(athlete.aname)
                .font(.title)
                .fontWeight(.bold)
                
                Spacer()
                
                Text(athlete.grade)
                .font(.title)
                .fontWeight(.bold)
            }.padding()
        HStack{
            NavigationLink(destination: SchoolDetail()){
                
                    VStack(alignment: .leading){
                        
                        Text(athlete.sname)
                        //.font(.title)
                        //.fontWeight(.bold)
                        Text(athlete.mascot)
                    }
            }
                    Spacer()
                    VStack(alignment: .trailing){
                        
                        Text(athlete.state)
                        Text(athlete.city)
                            //.padding(.top, 4)
                    }
                }.padding(.horizontal)
            

        }
    }
}

struct AthleteDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteDetailHeader(athlete: temp)
    }
}
