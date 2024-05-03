import SwiftUI

struct BotaoEscolha: View {
    
    let texto: String
    
    @Binding var selectedLevel: String
    
    @Binding var reallySelectedLevel: String
    
    var body: some View {
        Button(action: {
            switch texto {
            case "Iniciante":
                withAnimation() {
                    selectedLevel = "Iniciante"
                    reallySelectedLevel = "iniciante"
                }
            case "Intermediário":
                withAnimation {
                    selectedLevel = "Intermediário"
                    reallySelectedLevel = "intermediario"
                }
            case "Avançado":
                withAnimation {
                    selectedLevel = "Avançado"
                    reallySelectedLevel = "avancado"
                }
            case "5KM":
                withAnimation {
                    selectedLevel = "5KM"
                    reallySelectedLevel = "5K"
                }
            case "10KM":
                withAnimation {
                    selectedLevel = "10KM"
                    reallySelectedLevel = "10K"
                }
            case "15KM":
                withAnimation {
                    selectedLevel = "15KM"
                    reallySelectedLevel = "15K"
                }
            default:
                break
            }
        }, label: {
            ZStack {
                if selectedLevel == texto {
                    Color.ourLightBlue
                } else {
                    Color.oceanBlue
                }
                Text(texto)
                    .foregroundStyle(.white)
                    .font(.title2.bold())
            }
            .frame(width: 317, height: 69)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(selectedLevel == texto ? RoundedRectangle(cornerRadius: 20).stroke(Color.turquoiseGreen, lineWidth: 5) : nil)
        })
    }
}

//#Preview {
//    BotaoEscolha(texto: "Iniciante")
//}
