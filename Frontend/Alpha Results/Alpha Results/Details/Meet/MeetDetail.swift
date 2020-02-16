//
//  MeetDetail.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/6/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct MeetDetail: View {
    @State var meet: Meet
    
    @State var index: Int = 0
    
    var body: some View {
        VStack{
            MeetDetailHeader(meet: self.meet)
            Picker(selection: self.$index.animation(.spring(response: 0.55, dampingFraction: 1, blendDuration: 0)), label: Text(""),content: {
                 Text("Results").tag(0)
                 Text("Schools").tag(1)
                 Text("Score").tag(2)
                 Text("Search").tag(3)
             })
             .pickerStyle(SegmentedPickerStyle())
             .padding(.horizontal)
             LabeledScroll(index: $index, pages:
                 [
                     MeetInfo(id: 0, dataIndex: "Results"),
                     MeetInfo(id: 1, dataIndex: "Schools"),
                     MeetInfo(id: 2, dataIndex: "Scores"),
                     MeetInfo(id: 3, dataIndex: "Search")
                 ]
             )
        }
        .navigationBarTitle("Meet", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {}, label: {Image(systemName: "bookmark")}))
    }
}
