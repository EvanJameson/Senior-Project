//
//  PageScroll.swift
//  Alpha Results
//
//  Created by Evan Jameson on 2/11/20.
//  Copyright © 2020 Evan Jameson. All rights reserved.
//

import SwiftUI

struct PageScroll<Content: View & Identifiable>: View {

    @State var spacin: CGFloat// = 25.0
    @State var left: CGFloat// = 15
    @Binding var index: Int
    @State private var offset: CGFloat = 0
    @State private var isGestureActive: Bool = false
    
    
    

    // 1
    var pages: [Content]

    var body: some View {
        
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: -self.spacin) {
                    ForEach(self.pages) { page in
                        page
                            .frame(width: geometry.size.width, height: nil)
                    }
                }
            }
            // 2
                .content.offset(x: self.isGestureActive ? self.offset : (math(op1: (-geometry.size.width * CGFloat(self.index)),op2: (self.spacin * CGFloat(self.index)))) - self.left)
                
                //(math(op1: (-geometry.size.width * CGFloat(self.index)),op2: (self.spacin * CGFloat(self.index))))
            // 3
            .frame(width: geometry.size.width, height: nil, alignment: .leading)
            .gesture(DragGesture()
                .onChanged({ value in
                // 4
                self.isGestureActive = true
                // 5
                    self.offset = math(op1: (value.translation.width + -geometry.size.width * CGFloat(self.index) ), op2:(self.spacin * CGFloat(self.index))) - self.left
            }).onEnded({ value in
                if -value.predictedEndTranslation.width > geometry.size.width / 2, self.index < self.pages.endIndex - 1 {
                    self.index += 1
                }
                if value.predictedEndTranslation.width > geometry.size.width / 2, self.index > 0 {
                    self.index -= 1
                }
                // 6
                withAnimation(.spring(response: 0.55, dampingFraction: 1, blendDuration: 0)) { self.offset = math(op1: (-geometry.size.width * CGFloat(self.index) ), op2: (self.spacin * CGFloat(self.index))) - self.left}
                // 7
                DispatchQueue.main.async { self.isGestureActive = false }
            }))
        }
    }
}

func math(op1: CGFloat, op2: CGFloat) -> CGFloat{
    
    return CGFloat(op1) + CGFloat(op2)
}
