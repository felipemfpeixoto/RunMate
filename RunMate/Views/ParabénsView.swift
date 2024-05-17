import SwiftUI

struct ParabénsView: View {
    @State private var animateMedal = false
    @Binding var apareceParabens: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.oceanBlue)
                .stroke(Color.turquoiseGreen, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .padding(25)
            
            VStack(spacing: 15) {
                
                Text("PARABÉNS!")
                    .font(Font.custom("Poppins-SemiBold", size: 22))
                    .foregroundStyle(Color.turquoiseGreen)
                    .padding(.top, 60)
                
                Text("Você concluiu sua \(dao.semanaAtual)ª semana e recebeu um emblema!")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 25)
                    .multilineTextAlignment(.center)
                
                Text("Bora para a próxima semana?")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 25)
                    .padding(.bottom, 5)
                
                Button(action: {apareceParabens = false}, label: {
                    Text("VER PRÓXIMA SEMANA")
                        .foregroundColor(.oceanBlue)
                        .font(Font.custom("Poppins-SemiBold", size: 18))
                        .padding(.vertical, 16)
                        .padding(.horizontal, 25)
                        .background(Color.turquoiseGreen)
                })
                .cornerRadius(18)
            }
            .padding(.vertical, 25)
            .padding(.horizontal, 30)
            .cornerRadius(25)
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blackBlue.opacity(0.4))
        .onAppear {
            self.animateMedal.toggle() 
        }
    }
}



