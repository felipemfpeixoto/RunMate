//
//  IndiceView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct IndiceView: View {
    
    @Binding var apareceInfo: Bool
    
    var body: some View {
        
        ZStack{
            Color(.lakeBlue).ignoresSafeArea()
            
            VStack{
                
                HStack{
                    Spacer()
                    
                    Button {
                        apareceInfo = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(.trailing, 30)
                            .padding(.bottom, 20)
                    }
                }
                
                Text("Índice de Corridas")
                    .foregroundStyle(.white)
                    .font(.custom("Roboto-Bold", size: 24))
                    .padding(.bottom, 30)
                
                VStack{
                    HStack{
                        Text("Caminhada | FCM de 50% a 65%")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Corrida Leve | FCM de 65% a 75%")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Corrida Moderada | FCM de 75% a 85%")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Corrida Forte | FCM de 85% a 90%")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Corrida Muito Forte | FCM de 90% a 100%")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Tempo Run | Simulação do ritmo de prova")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Progressiva | Corrida gradual, Leve para Forte")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack{
                    HStack{
                        Text("Regressiva | Corrida gradual, Forte para Leve")
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                        
                }
                .frame(width: 343, height: 47)
                .background(Color.oceanBlue)
                .cornerRadius(9)
                
                VStack(alignment: .leading, spacing: 10){
                    
                    Text("FCM = Frequência Cardíaca Máxima")
                        .font(.custom("Roboto-Regular", size: 16))
                        .foregroundStyle(.white)
                    
                    Text("RunMate utiliza sua idade para calcular a \nFCM de cada tipo de corrida do seu treino.")
                        .font(.custom("Poppins-Regular", size: 13))
                        .foregroundStyle(.ourLightBlue)
                }
                .padding(.top, 30)
                
            }
            .font(.custom("Poppins-Medium", size: 13))
            
        }
        
    }
}

#Preview {
    IndiceView(apareceInfo: .constant(true))
}
