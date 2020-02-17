//
//  RaceDetail.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/16/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct RaceDetail: View {
    @EnvironmentObject var userData: UserData
    @State var race: Race
    @State var index: Int = 0
    
    var body: some View {
        VStack{
            Text(race.mark)
        }
    }
}
