//
//  SemanaView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaView: View {
    
    @State var diaAtual: Int = 1
   
    var body: some View {
        ZStack{
            Color(.blackBlue).ignoresSafeArea()
            VStack{
                Spacer()
                VStack(alignment: .leading){
                    
                    HStack (alignment: .top){
                        
                        VStack(alignment: .leading){
                            Text("Minha meta")
                                .font(Font.custom("Roboto-Bold", size: 28))
                                .foregroundStyle(Color.white)
                            
                            Text("5 km - Avançado") // Mudar quando já tiver as planilhas
                                .font(Font.custom("Roboto-Regular", size: 24))
                                .foregroundStyle(Color.turquoiseGreen)
                                .padding(.bottom, 30)
                        }
                        
                        Spacer()
                        Text(Image(systemName: "figure.run.circle.fill"))
                            .foregroundStyle(Color.turquoiseGreen)
                            .font(.system(size: 43))
                            .padding(.trailing, 10)
                            
                            
                    }
//                    Spacer()
                    
                    Text("Primeira semana")
                        .font(Font.custom("Roboto-Bold", size: 24))
                        .foregroundStyle(Color.white)
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        
                        HStack{
//                            ForEach(semana.dias, id: \.self)
                            ForEach(1..<8){ dia in
                                Group{
                                    if dia == diaAtual {
                                        Button(action: {
                                            diaAtual = dia
                                        }, label: {
                                            VStack{
                                                Text("\(dia)º")
                                                    .font(Font.custom("Roboto-Bold", size: 30))
                                                Text("Dia")
                                                    .font(Font.custom("Roboto-Bold", size: 18))
                                            }
                                            .foregroundStyle(Color.oceanBlue)
                                        })
                                        .buttonStyle(BotaoDiaTurquesa())
                                    }
                                    else {
                                        Button(action: {
                                            diaAtual = dia
                                        }, label: {
                                            VStack{
                                                Text("\(dia)º")
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
                    }
                    
//                    Spacer()
                    VStack{
                        ExerciciosDetalhadosView()
                        ExerciciosDetalhadosView()
                        ExerciciosDetalhadosView()
                    
                    }
                    .padding(.vertical, 40)
                    
                 Spacer()
                }
                .padding(.leading)
                .padding(.top, 40)
                
                VStack{
                    Button(action: {
                        
                    }, label: {
                        Text("CONCLUIR CORRIDA")
                            .font(Font.custom("Poppins-SemiBold", size: 18))
                            .foregroundStyle(Color.white)
                        Text(Image(systemName: "checkmark.seal.fill"))
                            .foregroundStyle(Color.turquoiseGreen)
                            .font(.system(size: 20))
                        
                    })
                    .padding(10)
                    .frame(width: 243, height: 43, alignment: .center)
                    .background(Color.oceanBlue)
                    .cornerRadius(11)
                }
                .padding(.bottom, 40)
                Spacer()
            }
        }
        
    }
}

#Preview {
    SemanaView()
}
