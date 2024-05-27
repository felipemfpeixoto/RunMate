//
//  RunMateApp.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI
import PostHog

//let postHog: AppDelegate = AppDelegate()

@main
struct RunMateApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @State var isShowingAviso = false
    
    @State var isEditing: Bool = false
    
    init() {
        let POSTHOG_API_KEY = "phc_AxlN5EBuL7CnSCUQPr8tVpiKhwsF6AmmfAeohITWklP"
        let POSTHOG_HOST = "https://us.i.posthog.com"
        
        let config = PostHogConfig(apiKey: POSTHOG_API_KEY, host: POSTHOG_HOST)
        PostHogSDK.shared.setup(config)
        #if DEBUG
        PostHogSDK.shared.identify("ehNos", userProperties: ["environment": "debug"])
        #else
        PostHogSDK.shared.identify("ehNos", userProperties: ["environment": "release"])
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ZStack{
                    if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count == 0 || isEditing {
                        ContentView(isEditing: $isEditing, isShowingAviso: $isShowingAviso)
                    } else {
                        TelaTabView(isShowingAviso: $isShowingAviso, isEditing: $isEditing)
                    }
                }
                .onAppear {
                    print("Enviou")
                    PostHogSDK.shared.capture("Test Event")
//                    print(dao.dadosSemanas[0])
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
}
