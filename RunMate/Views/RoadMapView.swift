//
//  RoadMapView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct RoadMapView: View {
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
                    VStack {
                        ZStack {
                            Image("Road")
                                .resizable()
                                .scaledToFit()
                            
                            
//                            ZStack(alignment: .leading) {
//                                Rectangle()
//                                    .foregroundColor(.red)
//                                    .frame(width: 200, height: 70)
//                                    .cornerRadius(18)
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 18)
//                                            .stroke(Color.green, lineWidth: 4)
//                                    )
//                                
//                                Text("Semana 1")
//                                    .foregroundColor(.white)
//                                    .font(.title3)
//                                    .fontWeight(.semibold)
//                                    .padding(.horizontal) // Add padding to the text
//                            }
                        }
                    }
                }
            }
            .background(.blackBlue)
     
        }
    }


#Preview {
    RoadMapView()
}
