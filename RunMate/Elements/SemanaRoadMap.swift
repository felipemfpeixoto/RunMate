//
//  SemanaRoadMap.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI
enum Level: Int {
    case semana1 = 0
    case semana2 = 1
    case semana3 = 2
    case semana4 = 3
}

extension Level: CustomStringConvertible {
    var description: String {
        switch self {
        case .semana1: "Semana 1"
        case .semana2: "Semana 2"
        case .semana3: "Semana 3"
        case .semana4: "Semana 4"
        }
    }
}

struct SemanaRoadMap: View {
    let semana: Semana
    let isLocked: Bool
    
    var body: some View {
        ZStack {
            if isLocked {
                HStack(spacing: 0) {
                    ZStack(alignment: .leading) {
                        Text("Semana " + String(semana.semana))
                            .foregroundColor(.turquoiseGreen)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.trailing, 12)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(.blackBlue)
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.turquoiseGreen, lineWidth: 4)
                                
                            }
                        
                    }
                    .overlay(alignment: .trailing) {
                        Image("Cadeado")
                            .resizable()
                            .scaledToFit()
                            .alignmentGuide(.trailing, computeValue: { dimension in
                                dimension[HorizontalAlignment.center]
                            })
                    }
                    
                }
               .padding(.bottom, 20)
               .padding(.top, 15)
               
                
            } else {
                Text("Semana " + String(semana.semana))
                    .foregroundColor(.blackBlue)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 12)
                    .padding(.vertical, 20)
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.turquoiseGreen)
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.lilacPurple, lineWidth: 4)
                    }
                    .overlay(alignment: .trailing) {
                        Image("Medalha")
                            .resizable()
                            .scaledToFit()
                            .alignmentGuide(.trailing, computeValue: { dimension in
                                dimension[HorizontalAlignment.center]
                            })
                        
                    }
                    .padding(.bottom, 20)
                    .padding(.top, 15)
            }
               
        }
        .padding(.vertical, 12)
    }
}
