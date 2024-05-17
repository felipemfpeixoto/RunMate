//
//  RunMateApp.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

@main
struct RunMateApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var isShowingAviso = false
    
    var body: some Scene {
        WindowGroup {
            SemanaConcluidaView(isShowing: .constant(true), semana: Semana(semana: 1, dias: []))
//            ZStack{
//                if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count == 0 {
//                    ContentView(isEditing: false, isShowingAviso: $isShowingAviso)
//                } else {
//                    TelaTabView(isShowingAviso: $isShowingAviso)
//                    //                SemanaView(semana: dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias)
//                }
//            }
                .onChange(of: scenePhase) {
                    switch scenePhase {
                        
                    case .background:
                        do {
                            try DAO.instance.save()
                        } catch {
                            print("Se ferrou!", error)
                        }
                    case .inactive:
                        break
                    case .active:
                        break
                    @unknown default:
                        break
                    }
                }
        }
    }
}
