//
//  SeasonBests.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/16/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct SeasonBests: View, Identifiable {
    var id: Int
    let events = ["60 Meters", "200 Meters"]
    let bests: [Bests] = [Bests(id: 0, event: "60 Meters", season: "2020 Indoor", grade: "Fr", mark: "6.75", pr: "SR"), Bests(id: 1, event: "200 Meters", season: "2020 Outdoor", grade: "Fr", mark: "20.90", pr: "PR"), Bests(id: 2, event: "60 Meters", season: "2021 Indoor", grade: "So", mark: "6.66", pr: "PR")]
    let col = Color(UIColor(red: 107.0/255.0, green: 5.0/255.0, blue: 0.0/255.0, alpha: 1))
    
    var body: some View {
        ForEach(self.events, id: \.self){ event in
            VStack{
                HStack{
                    Text(event)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                    Spacer()
                }.padding([.top, .horizontal])
                    .background(self.col)
                ForEach(self.bests, id: \.self) { best in
                    
                    HStack{
                        if(best.event == event){
                            Text(best.season)
                                .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.03, alignment: .leading)
                            Spacer()
                            Text(best.grade)
                                .foregroundColor(self.col)
                                
                            Spacer()
                            NavigationLink(destination: RaceDetail(race: Race(id: 0, event: best.event, mark: best.mark))){
                                HStack{
                                    Text(best.mark)
                                    Text(best.pr)
                                }.frame(width: UIScreen.screenWidth * 0.3, height: UIScreen.screenHeight * 0.03, alignment: .trailing)
                            }
                        }
                    }.padding(.vertical, 4).padding(.horizontal)
                    
                }
                    
            }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.top, 15)
        }
    }
}

struct SeasonBests_Previews: PreviewProvider {
    static var previews: some View {
        SeasonBests(id: 0)
    }
}
