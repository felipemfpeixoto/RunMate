//
//  SemanaRoadMap.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

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
                            .background {
                                RoundedRectangle(cornerRadius: 18)
                                    .fill(.blackBlue)
                                    .frame(height: 80)
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.turquoiseGreen, lineWidth: 4)
                                    .frame(height: 80)
                            }
                    }
                    .overlay(alignment: .trailing) {
                        Image("Cadeado")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(CGSize(width: 2.0, height: 2.0))
                            .alignmentGuide(.trailing, computeValue: { dimension in
                                dimension[HorizontalAlignment.center]
                            })
                    }
                }
            } else if dao.semanaAtual == (semana.semana - 1) {
                Text("Semana " + String(semana.semana))
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.oceanBlue)
                            .frame(height: 80)
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.turquoiseGreen, lineWidth: 4)
                            .frame(height: 80)
                    }
                    .overlay(alignment: .trailing) {
                        Image("cadeadoAberto")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(CGSize(width: 2.0, height: 2.0))
                            .alignmentGuide(.trailing, computeValue: { dimension in
                                dimension[HorizontalAlignment.center]
                            })
                        
                    }
            } else {
                Text("Semana " + String(semana.semana))
                    .foregroundColor(.blackBlue)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 12)
                    .background {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(.turquoiseGreen)
                            .frame(height: 80)
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.lilacPurple, lineWidth: 4)
                            .frame(height: 80)
                    }
                    .overlay(alignment: .trailing) {
                        Image("Medalha")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(CGSize(width: 2.0, height: 2.0))
                            .alignmentGuide(.trailing, computeValue: { dimension in
                                dimension[HorizontalAlignment.center]
                            })
                        
                    }
            }
               
        }
        .frame(width: 250)
    }
}
