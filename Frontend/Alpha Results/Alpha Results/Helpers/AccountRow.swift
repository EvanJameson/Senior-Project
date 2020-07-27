//
//  AccountRow.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/12/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AccountRow: View {
    
    var body: some View {
        HStack{
            //Make this some random generated color thing
            CircleImage(image: Image("3"), wh: 55.0)
                .padding(.leading, -7)
                

            VStack(alignment: .leading){
                Text("Evan Jameson")
                    .padding(.bottom, 4)
                
                Text("View Athlete Profile")
                    .foregroundColor(.gray)
                .font(.system(size: 13))
                
            }
            .padding(.leading, 5)
            Spacer()
        }
    }
}


struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AccountRow()
        
        }
    }
}
