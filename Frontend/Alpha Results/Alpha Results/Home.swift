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
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State var trail: CGFloat = 27.5
    
    //Maintain items
    //Home
    @State var recentMeets: Bool = true
    @State var nearbyMeets: Bool = true
    @State var friends: Bool = true
    @State var bookmarks: Bool = true
    @State var times: Bool = true
    
    @State var homeItems: [String] = ["Recent Meets", "Meets Near You", "Friends Races", "Bookmarked Athletes", "Fast Times"]
    @State var editHomeItems: Bool = false
    @State var selectKeeper = Set<String>()
    
    @State private var showSettings = false
    
    //Indexes
    //Home
    @State var index1: Int = 0
    @State var index2: Int = 0
    @State var index3: Int = 0
    @State var index4: Int = 0
    
    //Rankings
    @State var index5: Int = 0
    @State var index6: Int = 0
    @State var index7: Int = 0
    @State var index8: Int = 0
    
    var body: some View {
        //NavigationView{
            TabView {
                NavigationView{
                    List{
                        if(self.recentMeets){
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
                                .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.35, alignment: .center)
                                    
                            }
                        }
                        
                        if(self.nearbyMeets){
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
                        }
                        
                        if(self.friends){
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
                                .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.3, alignment: .leading)
                                
                            }
                        }
                        
                        if(self.bookmarks){
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
                            .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.36, alignment: .leading)
                        }
                       
                        if(self.times){
                            VStack {
                                HStack {
                                    Text("Fast Times")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                PageScroll(spacin: 25.0, left: 15.0, index: $index4, pages: (1..<5).map { index in LargeScrollBox(id: index,image: Image("\(index)")) })
                                    .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.35, alignment: .center)
                            }
                        }
                        
                    }
                    .navigationBarTitle("Home")
                    .navigationBarItems(trailing:
                        Button(action: {
                            self.showSettings.toggle()
                        })
                        {
                            Image(systemName: "person.crop.circle").imageScale(.large)
                        }.sheet(isPresented: $showSettings) {
                            Settings(showSettings: self.$showSettings).environmentObject(self.userData)
                            }
                        )
                }
                .tabItem {
                    VStack {
                        Image("timer")
                        Text("Home")
                    }
                    
                }
                
                NavigationView{
                    List{
                        VStack{
                            HStack {
                                Text("Events")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                .padding(.trailing, self.trail)
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
                        VStack{
                            HStack {
                                Text("Sections Current Leaders")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                .padding(.trailing, self.trail)
                                .foregroundColor(.blue)
                            }
                            PageScroll(spacin: 25.0, left: 15.0, index: $index5, pages: (1..<5).map { index in LargeScrollBox(id: index,image: Image("\(index)")) })
                                .frame(width: UIScreen.screenWidth * 1, height: UIScreen.screenHeight * 0.35, alignment: .center)
                        }
                        
                        VStack{
                            HStack {
                                Text("Leagues Most Improved")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Button("See All", action: {})
                                .padding(.trailing, self.trail)
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
                        
                        
                        
                        //league rankings
                        //section rankings
                        //state ....
                        //national ....
                        //new school records
                        //improvements in those sections
                        //no handtimes, auto only
                        
                    }
                    .navigationBarTitle("Rankings")
                    .navigationBarItems(trailing:
                    Button(action: {
                        self.showSettings.toggle()
                    })
                    {
                        Image(systemName: "person.crop.circle").imageScale(.large)
                    }.sheet(isPresented: $showSettings) {
                        Settings(showSettings: self.$showSettings).environmentObject(self.userData)
                        }
                    )
                
                    
                }
                .tabItem {
                    VStack {
                        Image("podium")
                        Text("Rankings")
                    }
                }
                
                NavigationView{
                    SearchList().environmentObject(self.userData)
                    .navigationBarTitle("Search")
                    .navigationBarItems(trailing:
                    Button(action: {
                        self.showSettings.toggle()
                    })
                    {
                        Image(systemName: "person.crop.circle").imageScale(.large)
                    }.sheet(isPresented: $showSettings) {
                        Settings(showSettings: self.$showSettings).environmentObject(self.userData)
                        }
                    )
                    .background(NavigationConfigurator { nc in
                        if((self.colorScheme) == .light){
                            nc.navigationBar.barTintColor = .white
                        }
                        else if((self.colorScheme) == .dark){
                            nc.navigationBar.barTintColor = .black
                        }
                        
                        //nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
                    })
                    //.navigationViewStyle(StackNavigationViewStyle())
                }
                    
                .tabItem {
                    VStack {
                        Image("search")
                        Text("Search")
                    }
                }
            }
    
    }
    func delete(at offsets: IndexSet) {
        self.homeItems.remove(atOffsets: offsets)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
