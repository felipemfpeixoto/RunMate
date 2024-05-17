//
//  TelaTabView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 16/05/24.
//

import SwiftUI

struct TelaTabView: View {
    
    @Binding var isShowingAviso: Bool
    
    var body: some View {
        TabView {
            
            SemanaView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            RoadMapView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
        }
        .fullScreenCover(isPresented: $isShowingAviso, content: {
            AvisoView(isShowingPopUp: $isShowingAviso)
        })
    }
}

#Preview {
    TelaTabView(isShowingAviso: .constant(false))
}
