//
//  TelaTabView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 16/05/24.
//

import SwiftUI

struct TelaTabView: View {
    
    @Binding var isShowingAviso: Bool
    
    @Binding var isEditing: Bool
    
    @State var telaSelecionada: TelaSelecionada = .home
    
    var isBlocked: Bool {
        if !dao.isPurchased {
            return dao.semanaAtual > 0 || dao.diaAtual > 4
        }
        else{
            return false
        }
    }
    
    @State var showPro = dao.isBlocked
    
    var body: some View {
        TabView(selection: $telaSelecionada) {
            
            SemanaView(isEditing: $isEditing, showPro: $showPro)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(TelaSelecionada.home)
            
            RoadMapView(telaSelecionada: $telaSelecionada, isEditing: $isEditing)
                .tabItem {
                    Image(systemName: "road.lanes")
                    Text("Road Map")
                }
                .tag(TelaSelecionada.roadmap)
            
            PerfilView(isEditing: $isEditing, showPro: $showPro)
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
                .tag(TelaSelecionada.profile)
        }
        .accentColor(Color.turquoiseGreen)
        .fullScreenCover(isPresented: $isShowingAviso, content: {
            AvisoView(isShowingPopUp: $isShowingAviso)
        })
        .onAppear{
            UITabBar.appearance().barTintColor = .blackBlue
            dao.isBlocked = isBlocked
            if isBlocked{
                showPro = true
            }
            else{
                showPro = false
            }
        }
    }
}

enum TelaSelecionada {
    case home, roadmap, profile
}
