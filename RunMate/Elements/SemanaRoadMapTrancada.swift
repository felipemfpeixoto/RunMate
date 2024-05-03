//
//  SemanaRoadMapTrancada.swift
//  RunMate
//
//  Created by Roberta Cordeiro on 03/05/24.
//

import SwiftUI

struct SemanaRoadMapTrancada: View {
    var body: some View {
        HStack(spacing: 0) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.blackBlue)
                    .frame(width: 200, height: 70)
                    .cornerRadius(18)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.turquoiseGreen, lineWidth: 4)
                    )
                Text("Semana 1")
                    .foregroundColor(.turquoiseGreen)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal) // Add padding to the text
                
                
                
                
            }
                Image("Cadeado")
                .offset(x: -50)
      
        }
    }
}

#Preview {
    SemanaRoadMapTrancada()
}
