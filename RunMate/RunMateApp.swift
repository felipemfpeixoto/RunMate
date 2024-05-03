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
    
    init() {
        for family in UIFont.familyNames{
            print(family)
            for font in UIFont.fontNames(forFamilyName: family){
                print(" \(font)")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
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
