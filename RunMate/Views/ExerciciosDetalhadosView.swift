//
//  ExerciciosDetalhadosView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct ExerciciosDetalhadosView: View {
    var body: some View {
        
        ZStack(alignment: .leading){

            
            HStack(spacing: 40){
                Text("10 MIN")
                    .font(.custom("Poppins-SemiBold", size: 18))
                    .padding(.leading, 40)
                
                VStack(alignment: .leading){
                    Text("Corrida Leve")
                        .font(.custom("Poppins-SemiBold", size: 18))
                    Text("FCM de 65% a 75%")
                        .font(.custom("Poppins-Medium", size: 14))
                }
            }
            .padding(.horizontal, 40)
            .foregroundColor(.white)
            .frame(width: 359, height: 65)
            .background(Color.oceanBlue)
            .cornerRadius(18)
            
            Text("1X")
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundColor(.oceanBlue)
                .frame(width: 63, height: 65)
                .background(Color.turquoiseGreen)
                .cornerRadius(18)

            
        }
    }
}

#Preview {
    ExerciciosDetalhadosView()
}
