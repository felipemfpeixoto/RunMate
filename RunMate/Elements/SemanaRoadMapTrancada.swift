//
//  SemanaRoadMapTrancada.swift
//  RunMate
//
//  Created by Roberta Cordeiro on 03/05/24.
//

import SwiftUI


struct SemanaRoadMapTrancada: View {
    let level: Level
    
    var body: some View {
        EmptyView()
    }
}

struct RoadShape: Shape {
    var right: Bool
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            if right {
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 0, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            } else {
                path.move(to: CGPoint(x: rect.maxX, y: 0))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                
            }
        }
        
    }
}
