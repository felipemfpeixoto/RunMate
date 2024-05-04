//
//  SemanaView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaView: View {
    
    @State var semana: [Dia]?
    @State var diaConcluido: Bool = false
   
    var body: some View {
        ZStack{
            Color(.blackBlue).ignoresSafeArea()
            if dao.semanaAtual == 0 {
                ProgressView()
            } else {
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
                        
                        Text("Primeira semana")
                            .font(Font.custom("Roboto-Bold", size: 24))
                            .foregroundStyle(Color.white)
                        
                        ScrollView(.horizontal, showsIndicators: true){
                            
                            HStack{
                                ForEach(semana ?? [], id: \.dia){ dia in
                                    Group{
                                        if diaConcluido{
                                            Button(action: {
                                                dao.diaAtual = dia.dia
                                            }, label: {
                                                VStack{
                                                    Text("\(dia.dia)º")
                                                        .font(Font.custom("Roboto-Bold", size: 30))
                                                    Text("Dia")
                                                        .font(Font.custom("Roboto-Bold", size: 18))
                                                }
                                                .foregroundStyle(Color.oceanBlue)
                                            })
                                            .buttonStyle(BotaoDiaLilas())
                                        }
                                        else{
                                            if dia.dia == dao.diaAtual {
                                                Button(action: {
                                                    dao.diaAtual = dia.dia
                                                }, label: {
                                                    VStack{
                                                        Text("\(dia.dia)º")
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
                                                    dao.diaAtual = dia.dia
                                                }, label: {
                                                    VStack{
                                                        Text("\(dia.dia)º")
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
                        }
                        
                        VStack{
                            ExerciciosDetalhadosView()
                        }
                        .padding(.vertical, 40)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top, 40)
                    
                    VStack{
                        Button(action: {
                            
                            if  dao.diaAtual == 7   {
                                dao.semanaAtual += 1
                            }
                            else{
                                dao.diaAtual += 1
                                diaConcluido = true
                            }
                            
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
                .onAppear {
                    semana = dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias
                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    SemanaView(semana: dao.paginaDeTreinamento.planoDeTreinamento.semanas.first!.dias)
}
