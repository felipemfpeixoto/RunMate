//
//  SemanaView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaView: View {
    var body: some View {
        ZStack{
            Color(.blackBlue).ignoresSafeArea()
            VStack{
                
                VStack(alignment: .leading){
                    Text("Minha meta")
                        .font(Font.custom("Roboto-Bold", size: 28))
                        .foregroundStyle(Color.white)
                    
                    Text("5 km - Avançado") // Mudar quando já tiver as planilhas
                        .font(Font.custom("Roboto-Bold", size: 24))
                        .foregroundStyle(Color.turquoiseGreen)
                        .padding(.bottom, 30)
                    
                    Text("Primeira semana")
                        .font(Font.custom("Roboto-Bold", size: 24))
                        .foregroundStyle(Color.white)
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        
                        HStack{
                            ForEach(1..<8){ number in
                                Button(action: {
                                    
                                }, label: {
                                    VStack{
                                        Text("\(number)º")
                                            .font(Font.custom("Roboto-Bold", size: 30))
                                        Text("Dia")
                                            .font(Font.custom("Roboto-Bold", size: 18))
                                    }
                                    
                                    .foregroundStyle(Color.white)
                                })
                                .buttonStyle(BotaoDia())
                                
                            }
                            
                        }
                    }
                    
                }
                .padding(.leading)
                
                VStack{
                    Button(action: {
                        
                    }, label: {
                        Text("CONCLUIR CORRIDA")
                            .font(Font.custom("Poppins-SemiBold", size: 18))
                            .foregroundStyle(Color.white)
                        
                    })
                    .padding(10)
                    .frame(width: 243, height: 43, alignment: .center)
                    .background(Color.oceanBlue)
                    .cornerRadius(11)
                }
            }
        }
        
    }
}

#Preview {
    SemanaView()
}
