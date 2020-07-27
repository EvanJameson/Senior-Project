//
//  MeetDetailHeader.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/15/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct MeetDetailHeader: View {
    
    @State var meet: Meet
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
               
                Text(dayFormatter(day: meet.day))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(meet.name)
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
        }
        .padding(.top)
        .padding(.leading)
        
    }
}


func dayFormatter(day: String) -> String {
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    var start = day.index(day.startIndex, offsetBy: 8)
    var end = day.index(day.startIndex, offsetBy: 10)
    var range = start..<end
    let newDay = String(day[range])
    
    start = day.index(day.startIndex, offsetBy: 5)
    end = day.index(day.startIndex, offsetBy: 7)
    range = start..<end
    let month = String(day[range])
    let newMonth = months[(Int(month)! - 1)]
    
    let newDate = newMonth + " " + newDay
    
    return newDate
}
