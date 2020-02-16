//
//  EditHome.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/12/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

var demoData = ["Recent Meets", "Meets Near You", "Friends Races", "Bookmarked Athletes", "Fast Times"]

struct EditContent: View {

    @Binding var showContent: Bool
    @State var selectKeeper = Set<String>()
    
    var body: some View {
        NavigationView{
            List(selection: $selectKeeper){
                ForEach(demoData, id: \.self) {d in
                    Text(d)
                    
                }
                .onMove(perform: move)
            }
                .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
        .navigationBarTitle("Edit Content", displayMode: .inline)
        }
    }
}

func move(from source: IndexSet, to destination: Int) {
    demoData.move(fromOffsets: source, toOffset: destination)
}
