//
//  AthleteInfo.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/14/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AthleteInfo: View, Identifiable {

    @State var id: Int
    
    @EnvironmentObject var userData: UserData
    @State var dataIndex: String = ""
    
    
    var body: some View {
        VStack{
            if(self.dataIndex == "Results"){
                AthleteResults().environmentObject(self.userData)
            }
            else if(dataIndex == "Records"){
                AthleteRecords()
            }
            else if(dataIndex == "Rankings"){
                AthleteRankings()
            }
        }
    }
}

struct AthleteResults: View {
    
    @EnvironmentObject var userData: UserData
    @State private var ngrok = "https://089cfda0.ngrok.io"
    @State private var refresh = false
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack{
//                Button(
//                    action: { self.refresh.toggle() },
//                    label: { Text("Toggle") }
//                )
                
                if (self.userData.athleteResults.seasons.count > 0){
                    ForEach(self.userData.athleteResults.seasons, id: \.self){ season in
                        VStack{
                            HStack{
                                Text(season)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                Spacer()
                            }.padding([.top, .horizontal])
                                .background(self.col)
//                            ForEach(self.holder.events, id: \.self) { event in
//                                VStack{
//                                    HStack{
//                                        Text(event)
//                                            .font(.headline)
//                                            .fontWeight(.bold)
//                                            .padding([.top, .leading])
//                                        Spacer()
//                                    }
//                                    ForEach(self.holder.athleteResults, id: \.self) { result in
//                                        HStack{
//                                            if(result.event == event){
//                                                Text(String(result.position))
//                                                Spacer()
//
//                                                //NavigationLink(destination: RaceDetail(race: Race(id: 0, event: result.event, mark: result.time))){
//                                                    Text(result.time)
//                                                        .foregroundColor(self.col)
//                                                //}
//                                                    Spacer()
//                                                Text(result.date)
//                                                //NavigationLink(destination: MeetDetail(meet: Meet(id: 0, name: result.meet, day: "2020-01-114389758943275987452", sport: "TF"))){
//                                                    HStack{
//
//                                                        Text(result.meet)
//
//                                                    }.frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.1, alignment: .trailing)
//                                                //}
//                                            }
//                                        }.padding(.vertical, 4).padding(.horizontal)
//                                    }
//                                }
//                            }
                        }.background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.top, 15)
                        .padding(.horizontal)
                    }
                }
                else{
                    VStack{
                        HStack{
                            Text("")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }.padding([.top, .horizontal])
                         .background(self.col)
                    }.background(Color.white)
                     .cornerRadius(10)
                     .shadow(radius: 5)
                     .padding(.top, 15)
                     .padding(.horizontal)
                    }
                
            }
            
        }
        .onAppear{
            resultsSearch(athleteID: 1, ngrok: self.ngrok){
                (res, error) in
                //self.holder = res!
                //self.oholder.holder = res!
                print(self.userData.athleteResults)
                self.userData.athleteResults = res!
                print(self.userData.athleteResults)
                print("Run")
            }

        }
    }
}

struct AthleteRecords: View {
    var body: some View {
        ScrollView(.vertical){
            SeasonBests(id: 0)
                .padding(.horizontal)
        }
    }
}

struct AthleteRankings: View {
    var body: some View {
        Text("Rankings")
        
    }
}

struct AthleteInfo_Previews: PreviewProvider {
    static var previews: some View {
        //let temp = AthleteSchool(id: 0, aname: "Evan Jameson", gender: "Male", grade: "SR", sid: 0, sname: "Cal Poly", mascot: "Mustangs", city: "San Luis Obispo", state: "CA")
        
        return AthleteInfo(id: 0, dataIndex: "Results")
    }
}

// performs search of DB on commit
// parses data thats returned and returns array of athletes
private func resultsSearch(athleteID: Int, ngrok: String, completionHandler: @escaping (ResultsHolder?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    //let newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    var res_list: [Result] = []
    var season_list: [String] = []
    var event_list: [String] = []
    
    // HTTP Request
    let url = URL(string: ngrok + "/athletes/athlete/results/" + String(athleteID))!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([Result].self, from: data)
                for value in qRes{
                    //Add result
                    let res = Result(id: value.id, mid: value.mid, meet: value.meet, date: value.date, sport: value.sport, position: value.position, time: value.time, distance: value.distance, pr: value.pr, sr: value.sr, wind: value.wind, season: value.season, handtime: value.handtime, converted: value.converted, marktype: value.marktype, eid: value.eid, event: value.event)
                    res_list.append(res)
                    
                    //Add season
                    if (!season_list.contains(value.season)){
                        season_list.append(value.season)
                    }
                    
                    //Add event
                    if (!event_list.contains(value.event)){
                        event_list.append(value.event)
                    }
                }
                var hold = ResultsHolder(id: 0)
                hold.athleteResults = res_list
                hold.seasons = season_list
                hold.events = event_list
                completionHandler(hold, nil)
            }
            catch {
                print(error)
            }
        }
    })
    task.resume()

    return
}
