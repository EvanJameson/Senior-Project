//
//  SmallScrollBox.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/11/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SmallScrollBox: View, Identifiable {
    var id: Int
    var image: Image
    var wh = UIScreen.screenWidth * 0.125
    var col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))

    var body: some View {
        VStack {
            HStack(){
                
                image
                .resizable()
                .frame(width: wh, height: wh)
                .cornerRadius(4)
                VStack(alignment: .leading){
                    Text("Miranda Daschian")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        //.foregroundColor(col)
                    
                    Text("5000m")
                    .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack {
                    Text("16:29")
                    Text("PR")
                    .fontWeight(.bold)
                        .foregroundColor(col)
                    .padding(.trailing)
                }
            }
            .padding(.trailing)
            
            HStack(){
                
                image
                .resizable()
                .frame(width: wh, height: wh)
                .cornerRadius(4)
                VStack(alignment: .leading){
                    Text("Sean McDermott")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        //.foregroundColor(col)
                    
                    Text("3000m Steeplechase")
                    .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack {
                    Text("9:02")
                    Text("PR")
                    .fontWeight(.bold)
                        .foregroundColor(col)
                    .padding(.trailing)
                }
            }
            .padding(.trailing)
            
            HStack(){
                
                image
                .resizable()
                .frame(width: wh, height: wh)
                .cornerRadius(4)
                VStack(alignment: .leading){
                    Text("Evan Jameson")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        //.foregroundColor(col)
                    
                    Text("10k (XC)")
                    .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack {
                    Text("30:10")
                    Text("PR")
                    .fontWeight(.bold)
                        .foregroundColor(col)
                    .padding(.trailing)
                }
            }
            .padding(.trailing)
            
            HStack(){
                
                image
                .resizable()
                .frame(width: wh, height: wh)
                .cornerRadius(4)
                VStack(alignment: .leading){
                    Text("Justin Robison")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        //.foregroundColor(col)
                    
                    Text("5000m")
                    .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack {
                    Text("14:14")
                    Text("PR")
                    .fontWeight(.bold)
                        .foregroundColor(col)
                        .padding(.trailing)
                }
            }
            .padding(.trailing)
            //.frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.06, alignment: .leading)
        }
        .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.3, alignment: .leading)
        
    }
}

struct SmallScrollBox_Previews: PreviewProvider {
    static var previews: some View {
        SmallScrollBox(id: 0, image: Image("3"))
    }
}
