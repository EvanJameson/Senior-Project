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
    @State var athleteId: Int = 0
    
    
    var body: some View {
        VStack{
            if(self.dataIndex == "Results"){
                AthleteResults(athleteId: self.athleteId).environmentObject(self.userData)
            }
            else if(dataIndex == "Records"){
                AthleteRecords(athleteId: self.athleteId)
            }
            else if(dataIndex == "Rankings"){
                AthleteRankings()
            }
        }
    }
}

struct AthleteResults: View {
    
    @State private var shouldAnimate = false
    @State var athleteId = 0
    @EnvironmentObject var userData: UserData
    @State private var host = "http://localhost:3000"
    @State private var refresh = false
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack{
                
                if (self.userData.athleteResults.seasons.count > 0){
                    ForEach(self.userData.athleteResults.seasons, id: \.self){ season in
                        VStack{
                            AthleteSeason(season: season)
                                
                            ForEach(self.userData.athleteResults.events[season]!, id: \.self) { event in
                                VStack{
                                    AthleteEvent(event: event)
                                    
                                    ForEach(self.userData.athleteResults.athleteResults, id: \.self) { result in
                                        AthleteResult(season: season, event: event, result: result)
                                    }
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.top, 15)
                        .padding(.horizontal)
                    }
                }
                else{
                    VStack{
                        AthleteSeason(season: "")
                        Spacer()
                        ActivityIndicator(shouldAnimate: self.$shouldAnimate)
                        Spacer()
                        
                    }.background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.top, 15)
                    .padding(.horizontal)
                }
            }
            
        }
        .onAppear{
            self.shouldAnimate.toggle()
            resultsSearch(athleteID: self.athleteId, host: self.host){
                (res, error) in
                self.shouldAnimate.toggle()
                self.userData.athleteResults = res!
            }

        }
        .onDisappear{
            self.userData.athleteResults = ResultsHolder(id: 0)
        }
    }
}

struct AthleteRecords: View {
    @State private var shouldAnimate = false
    @State var athleteId = 0
    @EnvironmentObject var userData: UserData
    @State private var host = "http://localhost:3000"
    @State private var refresh = false
    @State private var records = RecordsHolder(id: 0)
    
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View {
        
        ScrollView(.vertical){
            VStack{
                
                if (self.records.events.count > 0){
                    ForEach(self.records.events, id: \.self){ event in
                        VStack{
                            RecordEvent(event: event)
                                
                            ForEach(self.records.seasons[event]!, id: \.self) { season in
                                VStack{
                                    AthleteEvent(event: season)
                                    
                                    ForEach(self.records.athleteRecords, id: \.self) { record in
                                        RecordResult(season: season, event: event, record: record)
                                    }
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.top, 15)
                        .padding(.horizontal)
                    }
                }
                else{
                    VStack{
                        AthleteSeason(season: "")
                        Spacer()
                        ActivityIndicator(shouldAnimate: self.$shouldAnimate)
                        Spacer()
                        
                    }.background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.top, 15)
                    .padding(.horizontal)
                }
            }
            
        }
        .onAppear{
            self.shouldAnimate.toggle()
            recordsSearch(athleteID: self.athleteId, host: self.host){
                (res, error) in
                self.shouldAnimate.toggle()
                print("AthleteID: " + String(self.athleteId))
                print(self.records)
                self.records = res!
                print(self.records)
            }

        }
        .onDisappear{
            self.records = RecordsHolder(id: 0)
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
        return AthleteInfo(id: 0, dataIndex: "Results")
    }
}

//Season card
struct AthleteSeason: View{
    @State var season = ""
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View{
        HStack{
            Text(season)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }.padding([.top, .horizontal])
            .background(self.col)
    }
}

//Events
struct AthleteEvent: View{
    @State var event = ""
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View{
        HStack{
            Text(event)
                .font(.headline)
                .fontWeight(.bold)
                .padding([.top, .leading])
            Spacer()
        }
    }
}

//Results
struct AthleteResult: View{
    @State var season = ""
    @State var event = ""
    @State var result = Result(id: 0, mid: 0, meet: "", date: "", sport: "", position: 0, time: "", distance: 0.0, mark: "", pr: 0, sr: 0, wind: 0.0, seasonYear: "", seasonName: "", handtime: 0, converted: 0, marktype: "", eid: 0, event: "")
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View{
        HStack{
            if(self.result.event == event && self.result.seasonYear == season){
                Text(String(result.position))
                Spacer()
                Text(result.mark)
                    .foregroundColor(self.col)

                Spacer()
                Text(dayFormatter(day: result.date))
                    HStack{
                        Text(result.meet)
                    }.frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.1, alignment: .trailing)
            }
        }
            .padding(.horizontal)
    }
}

//Athelete Records
struct RecordEvent: View{
    @State var event = ""
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View{
        HStack{
            Text(event)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Spacer()
        }.padding([.top, .horizontal])
            .background(self.col)
    }
}

//Results
struct RecordResult: View{
    @State var season = ""
    @State var event = ""
    @State var record = Record(id: 0, time: "", mark: "", seasonYear: "", event: "")
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View{
        HStack{
            if(self.record.event == event && self.record.seasonYear == season){
                Text(String(record.seasonYear))
                Spacer()
                Text(String(record.mark))
                    .foregroundColor(self.col)
                Spacer()
            }
        }
            .padding(.horizontal)
    }
}


// performs search of DB on commit
// parses data thats returned and returns array of athletes
private func resultsSearch(athleteID: Int, host: String, completionHandler: @escaping (ResultsHolder?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    var res_list: [Result] = []
    var season_list: [String] = []
    var event_list: [String: [String]] = [:]
    
    // HTTP Request
    let url = URL(string: host + "/athletes/results/" + String(athleteID))!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([Result].self, from: data)
                for value in qRes{
                    //Add result
                    let res = Result(id: value.id, mid: value.mid, meet: value.meet, date: value.date, sport: value.sport, position: value.position, time: value.time, distance: value.distance, mark: value.mark, pr: value.pr, sr: value.sr, wind: value.wind, seasonYear: value.seasonYear, seasonName: value.seasonName, handtime: value.handtime, converted: value.converted, marktype: value.marktype, eid: value.eid, event: value.event)
                    res_list.append(res)
                    
                    //Add season
                    if (!season_list.contains(value.seasonYear)){
                        season_list.append(value.seasonYear)
                    }
                    
                    //Add event
                    //new season + event
                    if (event_list[value.seasonYear] == nil){
                        _ = event_list.updateValue([value.event], forKey: value.seasonYear)
                    }
                    //old season + new event
                    else if(!event_list[value.seasonYear]!.contains(value.event)){
                        var temp1 = event_list[value.seasonYear]!
                        temp1.append(value.event)
                        _ = event_list.updateValue(temp1, forKey: value.seasonYear)
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


// performs search of DB on commit
// parses data thats returned and returns array of athletes
private func recordsSearch(athleteID: Int, host: String, completionHandler: @escaping (RecordsHolder?, Error?) -> Void){
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    var res_list: [Record] = []
    var event_list: [String] = []
    var season_list: [String: [String]] = [:]
    
    // HTTP Request
    let url = URL(string: host + "/athletes/bests/" + String(athleteID))!
    let task = session.dataTask(with: url, completionHandler: { (receivedData: Data?, response: URLResponse?, error: Error?) -> Void in
        // Parse the data in the response and use it
        if let data = receivedData {
            do{
                let decoder = JSONDecoder()
                let qRes = try decoder.decode([Record].self, from: data)
                for value in qRes{
                    //Add result
                    let res = Record(id: value.id, time: value.time, mark: value.mark, seasonYear: value.seasonYear, event: value.event)
                    res_list.append(res)
                    
                    //Add season
                    if (!event_list.contains(value.event)){
                        event_list.append(value.event)
                    }
                    
                    //Add event
                    //new season + event
                    if (season_list[value.seasonYear] == nil){
                        _ = season_list.updateValue([value.seasonYear], forKey: value.event)
                    }
                    //old season + new event
                    else if(!season_list[value.event]!.contains(value.event)){
                        var temp1 = season_list[value.event]!
                        temp1.append(value.seasonYear)
                        _ = season_list.updateValue(temp1, forKey: value.event)
                    }
                }
                var hold = RecordsHolder(id: 0)
                hold.athleteRecords = res_list
                hold.seasons = season_list
                hold.events = event_list
                print(season_list)
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
