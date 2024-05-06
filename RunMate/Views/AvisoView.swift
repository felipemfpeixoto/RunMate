//
//  AvisoView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct AvisoView: View {
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.darkPurple)
                .stroke(Color.lilacPurple, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .padding(.horizontal, 20)// Add stroke around the rectangle
            
            
            
            VStack(spacing: 30) {
                Image("Alerta")
                    .shadow(color: .lilacPurple, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                 
                Text("ATENÇÃO!")
                    .font(Font.custom("Poppins-SemiBold", size: 22))
                    .foregroundStyle(Color.turquoiseGreen)
                  
                   
                
                Text("Antes de se exercitar ou participar de atividades físicas intensas, como corrida, consulte seu médico ou profissional de saúde.")
                    .font(Font.custom("Roboto-Medium", size: 18))
                    .padding(.horizontal, 15)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                
                
                Text("Certifique-se de sua saúde cardiovascular e de condições médicas pré-existentes.")
                    .font(Font.custom("Roboto-Medium", size: 18))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 15)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)
                
                
                Button(action: {
                    
                    
                    
                }, label: {
                    Text("ESTOU PRONTO!")
                    
                        .foregroundColor(.darkPurple)
                        .fontWeight(.bold)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 50)
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
    AvisoView()
}
