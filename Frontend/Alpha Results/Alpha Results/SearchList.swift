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
    
    @EnvironmentObject var userData: UserData
    
    @State private var searchText = ""
    @State private var ngrok = "https://cdbf9eab.ngrok.io"
    @State private var index = ""
    @State private var showCancelButton: Bool = false
    
    @State private var athletes =  [Athlete(id: 0 , name: "", gender: "", grade: "")]
    @State private var meets = [Meet(id: 0, name: "", day: "", sport: "")]
    @State private var schools = [School(id: 0, name: "", mascot: "", city: "", state: "")]
    
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
                        print(self.userData.searchIndex)
                        if (self.userData.searchIndex == "Athletes"){
                            self.index = "/athletes/name/"
                            athleteSearch(searchText: self.searchText, searchIndex: self.index, ngrok: self.ngrok){
                                (res, error) in
                                self.athletes = res!
                            }
                        }
                        else if (self.userData.searchIndex == "Meets"){
                            self.index = "/meets/name/"
                            meetSearch(searchText: self.searchText, searchIndex: self.index, ngrok: self.ngrok){
                                (res, error) in
                                self.meets = res!
                            }
                        }
                        else if (self.userData.searchIndex == "Schools"){
                            self.index = "/schools/name/"
                            schoolSearch(searchText: self.searchText, searchIndex: self.index, ngrok: self.ngrok){
                                (res, error) in
                                self.schools = res!
                            }
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
                        if (self.userData.searchIndex == "Athletes"){
                            ForEach(self.athletes, id:\.self) {athlete in
                                NavigationLink(destination: AthleteDetail(athlete: athlete)){
                                    SearchRow(athlete: athlete)
                                }
                            }
                        }
                        else if (self.userData.searchIndex == "Meets"){
                            ForEach(self.meets, id:\.self) {meet in
//                                NavigationLink(destination: MeetDetail(athlete: athlete)){
//                                    SearchRow(athlete: athlete)
//                                }
                                SearchRow(athlete: Athlete(id: 0, name: meet.name, gender: "", grade: ""))
                            }
                        }
                        else if (self.userData.searchIndex == "Schools"){
                            ForEach(self.schools, id:\.self) {school in
    //                                NavigationLink(destination: MeetDetail(athlete: athlete)){
    //                                    SearchRow(athlete: athlete)
    //                                }
                                SearchRow(athlete: Athlete(id: 0, name: school.name, gender: "", grade: ""))
                            }
                        }
                        
                    }
                    //.navigationBarTitle(Text("Search"))
                    .resignKeyboardOnDragGesture()
                }
                Spacer()
            }
        }
}

// performs search of DB on commit
// parses data thats returned and returns array of athletes
private func athleteSearch(searchText: String, searchIndex: String, ngrok: String, completionHandler: @escaping ([Athlete]?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [Athlete] = []
    
    // HTTP Request
    let url = URL(string: ngrok + searchIndex + newSearchText)!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([Athlete].self, from: data)
                for value in qRes{
                    let ath = Athlete(id: value.id, name: value.name, gender: value.gender, grade: value.grade)
                    res_list.append(ath)
                }
                completionHandler(res_list, nil)
            }
            catch {
                print(error)
            }
        }
    })
    task.resume()

    return
}

private func meetSearch(searchText: String, searchIndex: String, ngrok: String, completionHandler: @escaping ([Meet]?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [Meet] = []
    
    // HTTP Request
    let url = URL(string: ngrok + searchIndex + newSearchText)!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([Meet].self, from: data)
                for value in qRes{
                    let met = Meet(id: value.id, name: value.name, day: value.day, sport: value.sport)
                    res_list.append(met)
                }
                completionHandler(res_list, nil)
            }
            catch {
                print(error)
            }
        }
    })
    task.resume()

    return
}

private func schoolSearch(searchText: String, searchIndex: String, ngrok: String, completionHandler: @escaping ([School]?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [School] = []
    
    // HTTP Request
    let url = URL(string: ngrok + searchIndex + newSearchText)!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([School].self, from: data)
                for value in qRes{
                    let sch = School(id: value.id, name: value.name, mascot: value.mascot, city: value.city, state: value.state)
                    res_list.append(sch)
                }
                completionHandler(res_list, nil)
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

