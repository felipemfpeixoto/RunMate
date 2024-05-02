import SwiftUI

struct BotaoEscolha: View {
    
    let texto: String
    
    @Binding var selectedLevel: String
    
    var body: some View {
        Button(action: {
            switch texto {
            case "Iniciante":
                withAnimation() {
                    selectedLevel = "Iniciante"
                }
            case "Intermediário":
                withAnimation {
                    selectedLevel = "Intermediário"
                }
            case "Avançado":
                withAnimation {
                    selectedLevel = "Avançado"
                }
            default:
                break
            }
        }, label: {
            ZStack {
                Color.oceanBlue
                Text(texto)
                    .foregroundStyle(.white)
                    .font(.title2.bold())
            }
            .frame(width: 317, height: 69)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .opacity(selectedLevel == texto ? 0.4 : 1)
        })
    }
}

//#Preview {
//    BotaoEscolha(texto: "Iniciante")
//}
