//
//  RoadMapView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct RoadMapView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var textoSemanas: [String] = ["Primeira", "Segunda", "Terceira"]
    
    @State var semanas: [Semana]?
    
    var body: some View {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.medium)
                    })
                    Spacer()
                }
                .padding(.leading, 30)
                .padding(.bottom, 2)
                HStack {
                    Text("Minha meta")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading, 30)
                
                HStack {
                    Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) Km - \(dao.nivelSelecionado)")
                        .foregroundStyle(.turquoiseGreen)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.leading, 30)
                
                
                
                GeometryReader { geometry in
                    ScrollView {
                        VStack {
                            ForEach(semanas ?? [], id: \.self) { semana in
                                ZStack {
                                    if semana.semana % 2 == 1 {
                                        VStack {
                                            Image("impar")
                                                .resizable()
                                                .padding(.bottom, -50)
                                            SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                                                .padding(.trailing, 30)
                                                .padding(.bottom, -40)
                                                .onAppear {
                                                    print("week: " + String((semana.semana-1)))
                                                    print(dao.semanaAtual)
                                                }
                                        }
                                    } else {
                                        VStack {
                                            Image("par")
                                                .resizable()
                                                .padding(.bottom, -40)
                                            SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                                                .padding(.leading, 10)
                                                .padding(.bottom, -40)
                                                .onAppear {
                                                    print("week: " + String((semana.semana-1)))
                                                    print(dao.semanaAtual)
                                                }
                                        }
                                    }
                                }
                            }
                            if (semanas?.last?.semana ?? 1) % 2 == 1 {
                                Image("imparFinal")
                                    .resizable()
                                    .padding(.top, 40)
                            } else {
                                Image("parFinal")
                                    .resizable()
                                    .offset(x: 1)
                            }
                        }
                    }
            }
                
        }
        .background(.blackBlue)
        .navigationBarBackButtonHidden()
        .onAppear {
            semanas = dao.paginaDeTreinamento.planoDeTreinamento.semanas
        }
 
    }
    }


#Preview {
    RoadMapView()
}
