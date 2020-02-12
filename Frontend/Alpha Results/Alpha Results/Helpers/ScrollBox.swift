//
//  ScrollBox.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/9/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct ScrollBox: View {
    var image: Image
    var wh = UIScreen.screenWidth * 0.355
    var col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))

    var body: some View {
        
        
        VStack(alignment: .leading){
            image
                .resizable()
                .frame(width: wh, height: wh)
                .cornerRadius(4)
            
            
            Text("CIF-SDS Finals")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(col)
            
            Text("May 23, 2020'")
            .font(.subheadline)
                .foregroundColor(.gray)
            
        }
        .frame(width: 140, height: UIScreen.screenWidth * 0.65, alignment: .leading)
        
    }
}

struct ScrollBox_Previews: PreviewProvider {
    static var previews: some View {
        ScrollBox(image: Image("4"))
    }
}
