//
//  SemanaRoadMap.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaRoadMap: View {
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.turquoiseGreen)
                    .frame(width: 200, height: 70)
                    .cornerRadius(18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.lilacPurple, lineWidth: 4)
                    )
                Text("Semana 1")
                    .foregroundColor(.blackBlue)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal) // Add padding to the text
                
                
                
                
            }
                Image("Medalha")
                .offset(x: -50)
      
        }
    }
}

#Preview {
    SemanaRoadMap()
}
