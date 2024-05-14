//
//  AvisoView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct AvisoView: View {
    
    @State private var animateMedal = false
    @Binding var isShowingPopUp: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.darkPurple)
                .stroke(Color.lilacPurple, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 400)
                .padding(.horizontal, 20)
            
            
            
            VStack(spacing: 15) {
                Image("Alerta")
                    .shadow(color: .lilacPurple, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .scaleEffect(animateMedal ? 0.8 : 0.7)
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatCount(3, autoreverses: true)
                            .delay(0.2)
                        
                    )
                
                Text("ATENÇÃO!")
                    .font(Font.custom("Poppins-SemiBold", size: 22))
                    .foregroundStyle(Color.turquoiseGreen)
                    .padding(.bottom, 5)
                
                
                Text("Antes de se exercitar ou participar de atividades físicas intensas, como corrida, consulte seu médico ou profissional de saúde.")
                    .font(Font.custom("Poppins-SemiBold", size: 16))
                    .padding(.horizontal, 15)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                     
                
                
                Text("Certifique-se de sua saúde cardiovascular e de condições médicas pré-existentes.")
                    .font(Font.custom("Poppins-SemiBold", size: 16))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 15)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 10)
                
                
                Button(action: {
                    isShowingPopUp = false
                }, label: {
                    Text("ESTOU PRONTO!")
                    
                        .foregroundColor(.darkPurple)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .padding(.vertical, 16)
                        .padding(.horizontal, 50)
                        .background(Color.turquoiseGreen)

                        
                    
                })
                .cornerRadius(18)
                .padding(.top, 15)


            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .cornerRadius(25)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkPurple.opacity(0.9).ignoresSafeArea())
        .onAppear {
            self.animateMedal.toggle() 
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AvisoView(isShowingPopUp: .constant(true))
}
