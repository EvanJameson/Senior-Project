//
//  SearchList.swift
//  Alpha Results
//
//  Created by Evan Jameson on 11/17/19.
//  Copyright © 2019 Evan Jameson. All rights reserved.
//
// https://stackoverflow.com/questions/56490963/how-to-display-a-search-bar-with-swiftui
// this stack overflow showed me how to implement a search bar in SwiftUI

import SwiftUI
import Foundation

struct SearchList: View {
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    @State private var athletes =  Wrapper(athletes: [Athlete(id: 0 , name: "", gender: "", grade: "")])
    @State private var searched: Bool = false
    
var body: some View {
    VStack{
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")

                TextField("search", text: $searchText, onEditingChanged: { isEditing in
                    self.showCancelButton = true

                }, onCommit: {
                    print("onCommit")
                    search(searchText: self.searchText){
                        (res, error) in
                        self.athletes = res!
                    }
                    self.searched = true
                }).foregroundColor(.primary)
                  .keyboardType(.default) //Doesn't have "Done" key :(
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                if showCancelButton  {
                    Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchText = ""
                            self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton) // .animation(.default) // animation does not work properly
            
            //add unique toggle slider here to switch filter index
            ToggleIndex()
        
            if(searched){
                List {
                    // Filtered list of names
//                        ForEach(self.athletes.athletes.filter{$0.name.hasPrefix(searchText) || searchText == ""}, id:\.self) {athlete in
//                            NavigationLink(destination: AthleteDetail(athlete: athlete)){
//                                SearchRow(athlete: athlete)
//                            }
//                        }
                    ForEach(self.athletes.athletes, id:\.self) {athlete in
                        
                        NavigationLink(destination: AthleteDetail(athlete: athlete)){
                            SearchRow(athlete: athlete)
                        }
                    }
                    
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
            Spacer()
        }
    }
}

// performs search of DB on commit
// parses data thats returned and returns array of athletes
private func search(searchText: String, completionHandler: @escaping (Wrapper?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    
    // temp url created by ngrok
    let ngrok = "https://cdbf9eab.ngrok.io"
    
    // TODO: implement a filtering method to change search index
    let index = "/athletes/name/"
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)

    var res_list: [Athlete] = []
    var res_final = Wrapper(athletes: [Athlete(id: 0 , name: "PlaceHolder", gender: "", grade: "")])
    
    // HTTP Request
    let url = URL(string: ngrok + index + newSearchText)!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                
                
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([Athlete].self, from: data)
                for value in qRes{
                    print (value)
                    print ("name: " + value.name)
                    let ath = Athlete(id: value.id, name: value.name, gender: value.gender, grade: value.grade)
                    res_list.append(ath)
                }
                res_final = Wrapper(athletes: res_list)
                print("Yes")
                completionHandler(res_final, nil)
                
            }
            catch {
                print(error)
            }
        }
    })
    task.resume()

    return
}

struct SearchList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchList()
                .environment(\.colorScheme, .light)
            SearchList()
                .environment(\.colorScheme, .dark)
        }
    }
}

// helpers for


// these helpers resign the keyboard when the list is dragged
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

