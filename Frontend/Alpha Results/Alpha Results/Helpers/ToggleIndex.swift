//
//  ToggleIndex.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/17/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct ToggleIndex: View {
    
    @EnvironmentObject var userData: UserData
    
    @State var isOn: Bool = false
    @State var index: Int = 0
    @State var draggedOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            HStack {
                if (index == 0) {
                    Spacer()
                    .frame(width: -146, height: 0, alignment: .trailing)
                }
                if (index == 1) {

                }
                if (index == 2) {
                    Spacer()
                    .frame(width: 237, height: 0, alignment: .trailing)
                }
                  RoundedRectangle(cornerRadius: 8)
                    .fill(Color("tabSlider"))//make light mode white
                    .shadow(radius: 5)
                    .frame(width: 100, height: 30)
                    .animation(.spring())
            }
            .frame(width: 330, height: 10)
            .padding(EdgeInsets(top: 12, leading: 6, bottom: 12, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color("toggleBG"))
            .animation(.easeInOut)
        
            .cornerRadius(10.0)
            
            Text("Athletes")
                .offset(x: -119, y: 0)
                .onTapGesture {
                    self.index = 0
                    self.userData.searchIndex = "Athletes"
                }
            Text("Meets")
                .offset(x: 0, y: 0)
                .onTapGesture {
                    self.index = 1
                    self.userData.searchIndex = "Meets"
                }
            Text("Schools")
                .offset(x: 120, y: 0)
                .onTapGesture {
                    self.index = 2
                    self.userData.searchIndex = "Schools"
                }
            
        }
    }
}

struct ToggleIndex_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToggleIndex()
                .previewLayout(.fixed(width: 400, height: 80))
                .environment(\.colorScheme, .light)
            ToggleIndex()
                .previewLayout(.fixed(width: 400, height: 80))
                .environment(\.colorScheme, .dark)
        }
    }
}
