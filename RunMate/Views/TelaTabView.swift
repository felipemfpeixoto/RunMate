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
    
    var body: some View {
        TabView(selection: $telaSelecionada) {
            
            SemanaView(isEditing: $isEditing)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(TelaSelecionada.home)
            
            RoadMapView(telaSelecionada: $telaSelecionada)
                .tabItem {
                    Image(systemName: "road.lanes")
                    Text("Road Map")
                }
                .tag(TelaSelecionada.roadmap)
            
            PerfilView(isEditing: $isEditing)
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
        }
    }
}

enum TelaSelecionada {
    case home, roadmap, profile
}
