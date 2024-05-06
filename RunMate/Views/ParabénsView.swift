//
//  CongratulationsView.swift
//  RunMate
//
//  Created by Roberta Cordeiro on 03/05/24.
//

import SwiftUI

struct ParabénsView: View {
    //    @Binding var show : Bool
    
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.oceanBlue)
                .stroke(Color.turquoiseGreen, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                .padding(25)// Add stroke around the rectangle
            
            
            VStack(spacing: 20) {
                Image("Medalha")
                   // Adjust the padding as needed
                
                Text("PARABÉNS!")
                    .font(Font.custom("Poppins-SemiBold", size: 22))
                    .foregroundStyle(Color.turquoiseGreen)
                   
                
                Text("Você concluiu sua primeira semana e recebeu um emblema!")
                    .font(Font.custom("Roboto-Medium", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                
                
                Text("Bora pra próxima semana?")
                    .font(Font.custom("Roboto-Medium", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                
                Button(action: {}, label: {
                    Text("VER PRÓXIMA SEMANA")
                    
                        .foregroundColor(.oceanBlue)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 25)
                        .background(Color.turquoiseGreen)
                        .clipShape(Capsule())
                    
                })
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            /*.blur(radius: 3.0)*/ // Testar tipos de Blur
            .cornerRadius(25)
            
            
            
            
            
            Button(action: {
                
                //                    show.toggle()
                
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundColor(.lilacPurple)
                    .padding(.leading, 300)
                    .padding(.bottom, 650)
            })
            .padding()
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blackBlue.opacity(0.4))
//        .blur(radius: 3.0)
    }
}

#Preview {
    ParabénsView()
}
