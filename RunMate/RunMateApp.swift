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
            ZStack{
                if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count == 0 {
                    ContentView(isEditing: false, isShowingAviso: $isShowingAviso)
                } else {
                    TelaTabView(isShowingAviso: $isShowingAviso)
                }
            }
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
