//
//  SemanaView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaView: View {
    
    @State var semana: [Dia]?
//    @State var diasConcluidos: [Int] = []
   
    var body: some View {
        ZStack{
            Color(.blackBlue).ignoresSafeArea()
            if dao.semanaAtual == -1 {
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
                                        if dao.diasConcluidos.contains(dia.dia) {
                                            Button(action: {
                                                dao.diaAtual = (dia.dia - 1)
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
                                            if dia.dia == (dao.diaAtual + 1) {
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
                                                    dao.diaAtual = dia.dia - 1
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
                            ExerciciosDetalhadosView(exercicios: dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias[dao.diaAtual].exercicios)
                        }
                        .padding(.vertical, 40)
                        
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top, 40)
                    
                    VStack{
                        Button(action: {
                            
                            if  dao.diasConcluidos.count == 6   {
                                dao.diaAtual = 0
                                dao.diasConcluidos = []
                                dao.semanaAtual += 1
                                
                                
                                
                            }
                            else{
                                dao.diasConcluidos.append(dao.diaAtual+1)
                                dao.diaAtual += 1
                                print(dao.semanaAtual)
                                print(dao.diasConcluidos)
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
