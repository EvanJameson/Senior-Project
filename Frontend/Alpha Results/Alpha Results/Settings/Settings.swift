//
//  Settings.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/12/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Settings: View {
    
    @EnvironmentObject var userData: UserData
    @Binding var showSettings: Bool
    @State private var showContent = false
    
    let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
    
    var body: some View {
        NavigationView{
            
            List{
                Section(header: ProfileHeader(), footer: ProfileFooter()) {
                    NavigationLink(destination: AthleteDetail(athlete: self.temp).environmentObject(self.userData)){
                        AccountRow()
                            .padding(.leading)
                            .padding(.vertical, 3)
                    }
                    Text("Profile Settings")
                }
                
                
                Section(header: ContentHeader(), footer: ContentFooter()) {
                    Button(action: {
                        self.showContent.toggle()
                    })
                    {
                        Text("Edit Home Content")
                    }.sheet(isPresented: $showContent) {
                        EditContent(showContent: self.$showContent)
                        }
                    
                    Button(action: {
                        self.showContent.toggle()
                    })
                    {
                        Text("Edit Rankings Content")
                    }.sheet(isPresented: $showContent) {
                        EditContent(showContent: self.$showContent)
                        }
                    
                }
                Section(header: ListHeader2(), footer: ListFooter2()) {
                    Text("Location Settings")
                }
                
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Profile Settings", displayMode: .inline)
            .navigationBarItems(trailing:
                 Button("Done") {
                        self.showSettings.toggle()
                    }
        
                )
            
                
        }
    }
}

struct ProfileHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
            Text("PROFILE")
        }
    }
}

struct ProfileFooter: View {
    var body: some View {
        Text("View or claim athlete profile.")
    }
}

struct ContentHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "stopwatch")
            Text("CONTENT")
        }.padding(.top)
    }
}

struct ContentFooter: View {
    var body: some View {
        Text("Choose what you want and don't want to see as well as the order it's displayed in.")
    }
}

struct ListHeader2: View {
    var body: some View {
        HStack {
            Image(systemName: "location")
            Text("LOCATION")
        }.padding(.top)
    }
}

struct ListFooter2: View {
    var body: some View {
        Text("Edit location settings and permissions.")
    }
}
