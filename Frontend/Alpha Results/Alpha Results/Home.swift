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
    
    @State var trail: CGFloat = 27.5
    
    //recentMeets
    @State var index1: Int = 0
    @State var index2: Int = 0
    @State var index3: Int = 0
    @State var index4: Int = 0
    
    
    var body: some View {
        //NavigationView{
            TabView {
                NavigationView{
                    List{
                        VStack{
                            HStack {
                                Text("Recent Meets")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                    .padding(.trailing, self.trail)
                                    .foregroundColor(.blue)
                                
                            }
                            PageScroll(spacin: 25.0, left: 15.0, index: $index1, pages: (1..<5).map { index in LargeScrollBox(id: index,image: Image("\(index)")) })
                                
                        }.frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.4, alignment: .center)
                        VStack{
                            HStack {
                                Text("Meets Near You")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                    .padding(.trailing, 27.5)
                                    .foregroundColor(.blue)
                                
                            }
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 10) {
                                    ForEach(1..<5) {
                                        ScrollBox(image: Image("\($0)"))
                                    }
                                }
                            }.frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.275, alignment: .leading)
                        }
                        VStack {
                            HStack {
                                Text("Friends Races")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                    .padding(.trailing, 27.5)
                                    .foregroundColor(.blue)
                            }
                            PageScroll(spacin: 22.5, left: 0,index: $index2, pages: (1..<5).map { index in SmallScrollBox(id: index,image: Image("\(index)")) })
                            
                        }
                        .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.35, alignment: .leading)
                        VStack {
                            HStack {
                                Text("Bookmarked Athletes")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                    .padding(.trailing, 27.5)
                                    .foregroundColor(.blue)
                            }
                            PageScroll(spacin: 22.5, left: 0,index: $index3, pages: (1..<5).map { index in SmallScrollBox(id: index,image: Image("\(index)")) })
                        }
                        .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.35, alignment: .leading)
                        VStack {
                            HStack {
                                Text("Fast Times")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                    .padding(.trailing, 27.5)
                                    .foregroundColor(.blue)
                            }
                            PageScroll(spacin: 25.0, left: 15.0, index: $index4, pages: (1..<5).map { index in LargeScrollBox(id: index,image: Image("\(index)")) })


                        }.frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.4, alignment: .center)
                        
                        
                    }
                
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
