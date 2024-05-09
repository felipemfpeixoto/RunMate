//
//  SemanaView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaView: View {
    
    @State var semana: [Dia]?
    @State var apareceParabens: Bool = false
    @State var apareceInfo: Bool = false
    
    @State var isShowingAviso = false
   
    var body: some View {
        ZStack{
            Color(.blackBlue).ignoresSafeArea()
            if dao.semanaAtual == -1 {
                ProgressView()
                    .onAppear {
                        isShowingAviso.toggle()
                    }
            } else {
                VStack{
                    Spacer()
                    VStack(alignment: .leading){
                        
                        HStack (alignment: .top){
                            
                            VStack(alignment: .leading){
                                
    
                                Text("Minha meta")
                                        .font(Font.custom("Roboto-Bold", size: 28))
                                        .foregroundStyle(Color.white)
                                
                                Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) km - \(dao.nivelSelecionado)")
                                    .font(Font.custom("Roboto-Regular", size: 24))
                                    .foregroundStyle(Color.turquoiseGreen)
                                    .padding(.bottom, 30)
                            }
                            
                            
                            Spacer()
                            
                            HStack{
                                
                                NavigationLink(destination: RoadMapView(), label: {
                                    Text(Image(systemName: "figure.run.circle.fill"))
                                        .foregroundStyle(Color.turquoiseGreen)
                                        .font(.system(size: 30))
                                                                        })
                                
                                Button {
                                    apareceInfo = true
                                } label: {
                                    Text(Image(systemName: "info.circle"))
                                        .foregroundStyle(Color.turquoiseGreen)
                                        .font(.system(size: 30))
                                        .fontWeight(.light)
                                        .padding(.trailing, 10)

                                }
                              
                            }
                         
                        }
                        
                        Text("\(dao.semanaAtual+1)ª semana")
                            .font(Font.custom("Roboto-Bold", size: 24))
                            .foregroundStyle(Color.white)
                        
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack{
                                ForEach(semana ?? [], id: \.dia){ dia in
                                    Group{
                                        if dao.diasConcluidos.contains(dia.dia) {
                                            
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
                                                .buttonStyle(BotaoDiaLilas())
                                            }
                                            else{
                                                Button(action: {
                                                    dao.diaAtual = (dia.dia - 1)
                                                }, label: {
                                                    VStack{
                                                        Text("\(dia.dia)º")
                                                            .font(Font.custom("Roboto-Bold", size: 30))
                                                        Text("Dia")
                                                            .font(Font.custom("Roboto-Bold", size: 18))
                                                    }
                                                    .foregroundStyle(Color.white)
                                                })
                                                .buttonStyle(BotaoDiaDarkPurple())
                                            }
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
                                
                            }.padding(.leading, 10)
                        }.padding(.leading, -10)
                        
                    }
                    .padding(.leading)
                    .padding(.top, 40)
                    
                    if dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias[dao.diaAtual].exercicios.isEmpty{
                        VStack{
                            Text("DIA LIVRE")
                                .font(.custom("Poppins-SemiBold", size: 30))
                                .foregroundColor(.lakeBlue)
                                .padding(.top, 30)
                            Image("Cadeira")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 136, height: 133)
                            Text("Tire uma folga do seu \ncronograma de corrida e \naproveite um dia de descanso!")
                                .font(.custom("Poppins-SemiBold", size: 18))
                                .foregroundColor(.lakeBlue)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    }
                    else{
                        
                        VStack{
                            ExerciciosDetalhadosView(exercicios: dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias[dao.diaAtual].exercicios)
                            Spacer()
                        }
                        .padding(.vertical, 20)
                    }
                    
                    Spacer()
                    
                    if dao.diasConcluidos.contains(dao.diaAtual) || dao.diaAtual == 0 {
                        if dao.diasConcluidos.contains(dao.diaAtual + 1){
                            HStack{
                                Text("ETAPA CONCLUÍDA")
                                    .font(Font.custom("Poppins-SemiBold", size: 18))
                                    .foregroundStyle(Color.white)
                                Text(Image(systemName: "checkmark.seal.fill"))
                                    .foregroundStyle(Color.darkPurple)
                                    .font(.system(size: 20))
                            }
                            .padding(10)
                            .frame(width: 243, height: 43, alignment: .center)
                            .background(Color.lilacPurple)
                            .cornerRadius(11)
                            .padding(.bottom, 40)
                            Spacer()
                        }
                        else{
                            
                            VStack{
                                Button(action: {
                                    
                                    if  dao.diasConcluidos.count == 6   {
                                        dao.diaAtual = 0
                                        dao.diasConcluidos = []
                                        dao.semanaAtual += 1
                                        apareceParabens = true
                                    }
                                    else{
                                        dao.diasConcluidos.append(dao.diaAtual+1)
                                        dao.diaAtual += 1
                                        print(dao.semanaAtual)
                                        print(dao.diasConcluidos)
                                    }
                                    
                                }, label: {
                                    Text("CONCLUIR ETAPA")
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
                .onAppear {
                    semana = dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias
                    print(dao.semanaAtual)
                    print(dao.diasConcluidos)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .overlay{
            if apareceParabens{
                ZStack{
                    Color.black.opacity(0.3).ignoresSafeArea()
                    ParabénsView(apareceParabens: $apareceParabens)
                }
            }
        }
        .fullScreenCover(isPresented: $isShowingAviso, content: {
            AvisoView(isShowingPopUp: $isShowingAviso)
        })
        .sheet(isPresented: $apareceInfo){
            SemanaConcluidaView(apareceInfo: $apareceInfo)
                
        }
        
        
    }
}

#Preview {
    SemanaView(semana: dao.paginaDeTreinamento.planoDeTreinamento.semanas.first!.dias)
}
