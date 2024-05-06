import SwiftUI

struct ParabénsView: View {
    @State private var animateMedal = false // Estado para controlar a animação da medalha

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.oceanBlue)
                .stroke(Color.turquoiseGreen, lineWidth: 4)
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                .padding(25)
            
            VStack(spacing: 20) {
                Image("Medalha")
                    .shadow(color: .turquoiseGreen, radius: 15)
                    .scaleEffect(animateMedal ? 1.1 : 0.9) // Escala inicial é 1.1 quando animada, 0.9 quando não animada
                    .animation(
                        Animation.easeInOut(duration: 0.5) // Animando a escala da medalha
                            .repeatCount(3, autoreverses: true) // Repete uma vez e reverte
                            .delay(0.2) // Delay de 1 segundo antes de começar a animação
                    )
                
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
            .cornerRadius(25)
            
            Button(action: {}, label: {
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
        .onAppear {
            self.animateMedal.toggle() // Inicia a animação quando a view aparece
        }
    }
}

#Preview {
    ParabénsView()
}
