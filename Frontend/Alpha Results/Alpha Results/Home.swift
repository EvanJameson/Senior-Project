//
//  Home.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/15/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView{
            TabView {
                Text("Home").tabItem {
                    VStack {
                        Image("timer")
                        Text("Home")
                    }
                    
                }
                Text("Rankings").tabItem {
                    VStack {
                        Image("podium")
                        Text("Rankings")
                    }
                    
                }
                SearchList().tabItem {
                    VStack {
                        Image("search")
                        Text("Search")
                    }
                    
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
