//
//  SchoolDetail.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SchoolDetail: View {
    @State var school: School
    
    @State var index: Int = 0
    
    var body: some View {
        VStack{
            SchoolDetailHeader(school: self.school)
            Picker(selection: self.$index.animation(.spring(response: 0.55, dampingFraction: 1, blendDuration: 0)), label: Text(""),content: {
                 Text("Meets").tag(0)
                 Text("Records").tag(1)
             })
             .pickerStyle(SegmentedPickerStyle())
             .padding(.horizontal)
             LabeledScroll(index: $index, pages:
                 [
                     SchoolInfo(id: 0, dataIndex: "Meets"),
                     SchoolInfo(id: 1, dataIndex: "Records"),
                 ]
             )
        }
        .navigationBarTitle("School", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {}, label: {Image(systemName: "bookmark")}))
    }
}
