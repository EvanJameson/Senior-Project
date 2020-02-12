//
//  LargeScrollBox.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/11/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct LargeScrollBox: View, Identifiable {
    var id: Int
    
    var image: Image
    var w = UIScreen.screenWidth * 0.9
    var h = UIScreen.screenHeight * 0.27
    var col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))

    var body: some View {
        VStack(alignment: .leading){
            Text("California State Championship Finals")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(col)
            
            Text("May 30, 2020")
            .font(.subheadline)
                .foregroundColor(.gray)
            image
            .resizable()
            .frame(width: w, height: h)
            .cornerRadius(4)
        }
        .frame(width: UIScreen.screenWidth * 0.9, height: UIScreen.screenHeight * 0.35, alignment: .leading)
        
    }
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct LargeScrollBox_Previews: PreviewProvider {
    static var previews: some View {
        LargeScrollBox(id: 0, image: Image("3"))
    }
}
