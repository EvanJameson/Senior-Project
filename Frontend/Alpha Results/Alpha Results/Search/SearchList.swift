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
    @State private var host = "http://ec2-50-18-32-180.us-west-1.compute.amazonaws.com:3000"
    @State private var index = ""
    @State private var showCancelButton: Bool = false
    
    @State private var athleteSchools: [AthleteSchool] = []//= [AthleteSchool(id: 0 , aname: "", gender: "", grade: "", sid: 0, sname: "", mascot: "", city: "", state: "")]
    @State private var athletes =  [Athlete(id: 0 , name: "", gender: "", grade: "")]
    @State private var meets: [Meet] = [] //= [Meet(id: 0, name: "", day: "", sport: "")]
    @State private var schools: [School] = [] //= [School(id: 0, name: "", mascot: "", city: "", state: "")]
    
    @State private var athleteSearched: Bool = false
    @State private var meetSearched: Bool = false
    @State private var schoolSearched: Bool = false
    
    @State private var index1 = 0
    @State private var indices = ["Athletes", "Meets", "Schools"]
    @State private var searchIndex = ""
    
    @State private var shouldAnimate = false
    
    var body: some View {
        VStack{
            HStack{
                HStack{
                    Image(systemName: "magnifyingglass")

                    TextField("search", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: {
                        self.shouldAnimate = true
                        //print("onCommit")
                        //print(self.userData.searchIndex)
                        if (self.searchIndex == "Athletes"){
                            self.index = "/athletes/"
                            self.athleteSearched = true
                            athleteSearch(searchText: self.searchText, searchIndex: self.index, host: self.host){
                                (res, error) in
                                self.athleteSchools = res!
                            }
                        }
                        else if (self.searchIndex == "Meets"){
                            self.index = "/meets/"
                            self.meetSearched = true
                            meetSearch(searchText: self.searchText, searchIndex: self.index, host: self.host){
                                (res, error) in
                                self.meets = res!
                            }
                        }
                        else if (self.searchIndex == "Schools"){
                            self.index = "/schools/"
                            self.schoolSearched = true
                            schoolSearch(searchText: self.searchText, searchIndex: self.index, host: self.host){
                                (res, error) in
                                self.schools = res!
                            }
                        }
                        
                        if((self.athleteSchools.count > 0 && self.searchIndex == "Athletes")){
                            self.athleteSchools = []
                            self.athleteSearched = true
                        }

                        if((self.meets.count > 0 && self.searchIndex == "Meets")){
                            self.meets = []
                            self.meetSearched = true
                        }

                        if((self.schools.count > 0 && self.searchIndex == "Schools")){
                            self.schools = []
                            self.schoolSearched = true
                        }
                        
                    }
                    ).foregroundColor(.primary)
                      .keyboardType(.default)
                    Button(action: {
                        self.searchText = ""
                        if(self.searchText == "" && (self.athleteSchools.count > 0 && self.searchIndex == "Athletes")){
                            self.athleteSchools = []
                            self.athleteSearched = false
                        }

                        if(self.searchText == "" && (self.meets.count > 0 && self.searchIndex == "Meets")){
                            self.meets = []
                            self.meetSearched = false
                        }

                        if(self.searchText == "" && (self.schools.count > 0 && self.searchIndex == "Schools")){
                            self.schools = []
                            self.schoolSearched = false
                        }
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
                //.navigationBarHidden(showCancelButton)//.animation(.easeInOut) // animation does not work properly
                
                //add unique toggle slider here to switch filter index
                //ToggleIndex()
            Picker(selection: self.$index1.animation(.spring(response: 0.55, dampingFraction: 1, blendDuration: 0)) , label: Text(""),content: {
                    Text("Athletes").tag(0)
                    Text("Meets").tag(1)
                    Text("Schools").tag(2)
                })
                .onReceive([self.index1].publisher.first()) { (value) in
                    //self.toggleIndex(ind: value)
                    
                    self.searchIndex = self.indices[value]
                    //print("Value: " + String(value) + "\nIndex: " + self.indices[value] + "\nSearchIndex: " + self.searchIndex + "\n")
                    
                    //print(self.index)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
            
                if(athleteSearched && (self.athleteSchools.count == 0 && self.searchIndex == "Athletes")){
                    Spacer()
                    ActivityIndicator(shouldAnimate: self.$shouldAnimate)
                }
                if(meetSearched && (self.meets.count == 0 && self.searchIndex == "Meets")){
                    Spacer()
                    ActivityIndicator(shouldAnimate: self.$shouldAnimate)
                }
                if(schoolSearched && (self.schools.count == 0 && self.searchIndex == "Schools")){
                    Spacer()
                    ActivityIndicator(shouldAnimate: self.$shouldAnimate)
                }
                if((self.athleteSchools.count > 0)){
                    
                        if (self.searchIndex == "Athletes"){
                            List {
                            ForEach(self.athleteSchools, id:\.self) {athlete in
                                NavigationLink(destination: AthleteDetail(athlete: athlete).environmentObject(self.userData)){
                                    AthleteRow(athlete: athlete)
                                }
                            }
                        }.resignKeyboardOnDragGesture()
                            .listStyle(PlainListStyle())
                                
                    }
                    
                    
                }
                if((self.meets.count > 0)){
                    
                        if (self.searchIndex == "Meets"){
                            List{
                            ForEach(self.meets, id:\.self) {meet in
                                NavigationLink(destination: MeetDetail(meet: meet).environmentObject(self.userData)){
                                    MeetRow(meet: meet)
                                }
                                
                            }
                        }.resignKeyboardOnDragGesture()
                            .listStyle(PlainListStyle())
                            
                    }
                    
                }
                if((self.schools.count > 0)){
                    
                        if (self.searchIndex == "Schools"){
                            List{
                            ForEach(self.schools, id:\.self) {school in
                                NavigationLink(destination: SchoolDetail(school: school).environmentObject(self.userData)){
                                        SchoolRow(school: school)
                                    }
                            }
                        }.resignKeyboardOnDragGesture()
                            .listStyle(PlainListStyle())
                    }
                }
                else{Text("")}
                Spacer()
        }.animation(.easeInOut(duration: 0.2))
        }
}

// performs search of DB on commit
// parses data thats returned and returns array of athletes
private func athleteSearch(searchText: String, searchIndex: String, host: String, completionHandler: @escaping ([AthleteSchool]?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [AthleteSchool] = []
    
    // HTTP Request
    let url = URL(string: host + searchIndex + newSearchText)!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([AthleteSchool].self, from: data)
                for value in qRes{
                    let ath = AthleteSchool(id: value.id, aname: value.aname, gender: value.gender, grade: value.grade, sid: value.sid, sname: value.sname, mascot: value.mascot, city: value.city, state: value.state)
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

private func meetSearch(searchText: String, searchIndex: String, host: String, completionHandler: @escaping ([Meet]?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [Meet] = []
    
    // HTTP Request
    let url = URL(string: host + searchIndex + newSearchText)!
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

private func schoolSearch(searchText: String, searchIndex: String, host: String, completionHandler: @escaping ([School]?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [School] = []
    
    // HTTP Request
    let url = URL(string: host + searchIndex + newSearchText)!
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

//struct SearchList_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            SearchList()
//                .environment(\.colorScheme, .light)
//            SearchList()
//                .environment(\.colorScheme, .dark)
//        }
//    }
//}

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

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView()
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
