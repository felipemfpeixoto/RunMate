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
                    
                        ZStack {
                            Image("Road")
                                .resizable()
                                .scaledToFit()
                            VStack(spacing: 55) {
                                ForEach(Array(textoSemanas.enumerated()), id: \.self.element) { index, texto in
                                    HStack {
                                        if index % 2 == 0 {
                                            Spacer()
                                        }
                                        Text(texto)
                                            .font(.largeTitle)
                                            .foregroundStyle(.white)
                                        if index % 2 == 1 {
                                            Spacer()
                                        }
                                    }
                                }
                           
                            Spacer()
                            
                          
                        }
                            .padding(.top, 40)
                    }
                }
            }
            .background(.blackBlue)
     
        }
    }


#Preview {
    RoadMapView()
}
