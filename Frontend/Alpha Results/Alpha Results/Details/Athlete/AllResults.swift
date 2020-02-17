//
//  AllResults.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/16/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct AllResults: View, Identifiable {
    var id: Int
    let events = ["60 Meters", "200 Meters"]
    let results: [Result] = [
        Result(id: 0, position: "1", event: "60 Meters", season: "2020 Indoor", date: "Jan 11", mark: "6.75", pr: "SR", grade: "Fr", meet: "Clemson Orange & Purple Elite Indoor"),
    Result(id: 1, position: "3",event: "60 Meters", season: "2021 Indoor", date: "Jan 10", mark: "6.66", pr: "PR", grade: "So", meet: "Clemson Orange & Purple Elite Indoor"),
    Result(id: 2, position: "2", event: "200 Meters", season: "2020 Indoor", date: "Jan 15", mark: "20.90", pr: "PR", grade: "Fr", meet: "Arkansas Razorback Indoor Invitational")
    ]
    let seasons = ["2020 Indoor", "2021 Indoor"]

    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View {
        ForEach(self.seasons, id: \.self){ season in
            VStack{
                HStack{
                    Text(season)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                }.padding([.top, .horizontal])
                    .background(self.col)
                ForEach(self.events, id: \.self) { event in
                    VStack{
                        HStack{
                            Text(event)
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding([.top, .leading])
                            Spacer()
                        }
                        ForEach(self.results, id: \.self) { result in
                            HStack{
                                if(result.event == event){
                                    Text(result.position)
                                    Spacer()
                                        //.frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.03, alignment: .leading)
                                    NavigationLink(destination: RaceDetail(race: Race(id: 0, event: result.event, mark: result.mark))){
                                        Text(result.mark)
                                            .foregroundColor(self.col)
                                    }
                                        Spacer()
                                    Text(result.date)
                                    NavigationLink(destination: MeetDetail(meet: Meet(id: 0, name: result.meet, day: "2020-01-114389758943275987452", sport: "TF"))){
                                        HStack{
                                            
                                            Text(result.meet)
                                            
                                        }.frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.1, alignment: .trailing)
                                    }
                                }
                            }.padding(.vertical, 4).padding(.horizontal)
                        }
                    }
                }
                    
            }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.top, 15)
        }
    }
}
