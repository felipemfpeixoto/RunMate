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
    
    @State var semanas: [Semana] = []
    @State var semanaIndex: Int = 0

    @State var isShowingSheet: Bool = false
    
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
                    .font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundStyle(Color.white)
                Spacer()
            }
            .padding(.leading, 30)
            
            HStack {
                Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) km - \(dao.nivelSelecionado)")
                    .foregroundStyle(.turquoiseGreen)
                    .font(Font.custom("Roboto-Regular", size: 24))
                Spacer()
            }
            .padding(.leading, 30)
            
            
            
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        ForEach(Array(semanas.enumerated()) , id: \.offset) {index, semana in
                            semanaDaVez(for: index)
                                .onAppear{print("index: \(index)")}
                        }
                        Image("impar")
                            .resizable()
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
    
    func semanaDaVez(for index: Int) -> some View {
        let semana = semanas[index]
        
        return
        ZStack {
            VStack {
                Image( semana.semana % 2 == 1 ? "impar" : "par")
                    .resizable()
                Button {
                    self.semanaIndex = index
                    isShowingSheet.toggle()
                    print("****Button******", semanas[index].semana, index, self.semanaIndex)
                } label: {
                    if semana.semana % 2 == 1 {
                            SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                                .onAppear {
                                    print("week: " + String((semana.semana-1)))
                                    print(dao.semanaAtual)
                                }
                    } else {
                            SemanaRoadMap(semana: semana, isLocked: dao.semanaAtual < (semana.semana-1))
                                .onAppear {
                                    print("week: " + String((semana.semana-1)))
                                    print(dao.semanaAtual)
                                }
                    }
                }
                .padding(.leading, semana.semana == 1  ? -30 : 10)
                .padding(.top, -30)
                .sheet(isPresented: $isShowingSheet) {
                    // Mostrar o treino da semana clicada já concluído
                    Textin(index: $semanaIndex)
                }
            }
            .padding(.bottom, -16)
        }
    }
}


#Preview {
    RoadMapView(semanas: [Semana(semana: 1, dias: []), Semana(semana: 2, dias: []), Semana(semana: 3, dias: [])])
}


struct Textin: View {
    
    @Binding var index: Int
    var body: some View {
        Text("Semana \(index)")
    }
}
