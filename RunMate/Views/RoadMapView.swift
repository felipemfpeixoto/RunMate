//
//  RoadMapView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct RoadMapView: View {
    @State var textoSemanas: [String] = ["Primeira", "Segunda", "Terceira"]
    
        var body: some View {
                VStack {
                    HStack {
                        
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.medium)
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
                        Text("5 KM | Avançado")
                            .foregroundStyle(.turquoiseGreen)
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.leading, 30)
                    
                    
                        
                    ScrollView {
                        Spacer()
                        Spacer()
                        Spacer()
                            ForEach(dao.paginaDeTreinamento.planoDeTreinamento.semanas, id: \.semana){ semana in
                                SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                                    .padding(.leading, 30)
                                    .padding(.trailing, 30)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .onAppear {
                                        print("week: " + String((semana.semana-1)))
                                        print(dao.semanaAtual)
                                    }
                            }
                        
//                        
//                            .overlay {
//                                RoadShape(right: true)
//                                    .stroke(LinearGradient(colors: [.darkPurple, .lilacPurple, .lakeBlue, .turquoiseGreen], startPoint: .leading, endPoint: .trailing),
//                                            style: .init(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                                    .shadow(color: .lilacPurple, radius: 8, x: 0, y: 0)
//                                    
//                                RoadShape(right: true)
//                                    .stroke(.white,
//                                            style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round,
//                                                         dash: [10, 10])
//                                    )
//                            }
//                            .padding(.horizontal, 40)
//                           
//                        
//                        SemanaRoadMap(level: .semana2, isLocked: DAO.instance.semanaAtual <= Level.semana2.rawValue)
//                            .padding(.trailing, 45)
//                            .padding(.leading, 30)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .overlay {
//                                RoadShape(right: false)
//                                    .stroke(LinearGradient(colors: [.darkPurple, .lilacPurple, .lakeBlue, .turquoiseGreen], startPoint: .leading, endPoint: .trailing),
//                                            style: .init(lineWidth: 20, lineCap: .round, lineJoin: .round))
//                                    .shadow(color: .lilacPurple, radius: 12, x: 0, y: 0)
//                                RoadShape(right: false)
//                                    .stroke(.white,
//                                            style: .init(lineWidth: 5, lineCap: .round, lineJoin: .round,
//                                                         dash: [10, 10])
//                                            
//                                    )
//                            }
//                            .padding(.horizontal, 40)
                        
                }
                    
            }
            .background(.blackBlue)
           
        }
    }


#Preview {
    RoadMapView()
}
