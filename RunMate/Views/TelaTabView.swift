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
    
    var body: some View {
        TabView {
            
            SemanaView(isEditing: $isEditing)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
            
            RoadMapView()
                .tabItem {
                    Image(systemName: "road.lanes")
                    Text("Road Map")
                }
            
            PerfilView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Perfil")
                }
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

//#Preview {
//    TelaTabView(isShowingAviso: .constant(false))
//}
