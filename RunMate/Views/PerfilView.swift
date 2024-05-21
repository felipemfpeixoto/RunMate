//
//  PerfilView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI

struct PerfilView: View {
    
    @Binding var isEditing: Bool
    var body: some View {
        ZStack{
            Color.blackBlue.ignoresSafeArea()
            VStack{
                Spacer()
                header()
                Spacer()
                
                Button(action: {
                    isEditing = true
                }, label: {
                    Text("Resetar Escolhas")
                })
            }
        }
            
    }
}

struct header: View{
    var body: some View {
        HStack(){
            VStack(alignment: .leading){
                Text("Perfil do Corredror")
                    .font(Font.custom("Poppins-SemiBold", size: 24))
                    .foregroundStyle(Color.white)
                Text("Perfil do Corredror")
                    .font(Font.custom("Roboto-Regular", size: 24))
                    .foregroundStyle(Color.turquoiseGreen)
            }
            Spacer()
        }
        .padding(.leading)
    }
}

//#Preview {
//    PerfilView()
//}
