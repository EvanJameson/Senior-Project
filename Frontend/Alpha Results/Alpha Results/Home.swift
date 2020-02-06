//
//  Home.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/15/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        //NavigationView{
            TabView {
                NavigationView{
                    Text("Home")
                    .navigationBarTitle("Home")
                }
                .tabItem {
                    VStack {
                        Image("timer")
                        Text("Home")
                    }
                    
                }
                
                NavigationView{
                    Text("Rankings")
                    .navigationBarTitle("Rankings")
                }
                .tabItem {
                    VStack {
                        Image("podium")
                        Text("Rankings")
                    }
                }
                
                NavigationView{
                    SearchList()
                    .navigationBarTitle("Search")
                }
                .tabItem {
                    VStack {
                        Image("search")
                        Text("Search")
                    }
                }  
            }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
