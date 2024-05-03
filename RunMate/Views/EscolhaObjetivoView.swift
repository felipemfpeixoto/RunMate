import SwiftUI

struct EscolhaObjetivoView: View {
    
    @Binding var faseBonequinho: Int
    
    @Binding var selectedLevel: String
    
    @State var selectedGoal: String = ""
    
    @Binding var filenameGoal: String
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione seu objetivo:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                BotaoEscolha(texto: "5KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "10KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "15KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                Spacer()
                if selectedGoal != "" {
                    Button(action: {
                        withAnimation(Animation.easeInOut(duration: 0.75)) {
                            faseBonequinho = 3
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.turquoiseGreen)
                                .frame(width: 243, height: 56)
                            Text("Proximo")
                                .foregroundStyle(.black)
                                .font(.title3.bold())
                        }
                    })
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.turquoiseGreen)
                            .frame(width: 243, height: 56)
                        Text("Proximo")
                            .foregroundStyle(.black)
                            .font(.title3.bold())
                    }
                    .opacity(0.3)
                }
                Spacer()
            }
        }
    }
}

//#Preview {
//    EscolhaObjetivoView(selectedLevel: .constant(""))
//}
