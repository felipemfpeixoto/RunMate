import SwiftUI

struct EscolhaObjetivoView: View {
    
    @Binding var faseBonequinho: Int
    
    @Binding var selectedLevel: String
    
    @State var selectedGoal: String = ""
    
    @Binding var filenameGoal: String
    
    @Binding var imPrograssing: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione seu objetivo:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                BotaoEscolha(texto: "5 km", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "10 km", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "15 km", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                Spacer()
                if selectedGoal != "" {
                    Button(action: {
                        imPrograssing = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            faseBonequinho += 1
                        }
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.turquoiseGreen)
                                .frame(width: 243, height: 56)
                            Text("Próximo")
                                .foregroundStyle(.black)
                                .font(.title3.bold())
                        }
                    })
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.turquoiseGreen)
                            .frame(width: 243, height: 56)
                        Text("Próximo")
                            .foregroundStyle(.black)
                            .font(.title3.bold())
                    }
                    .opacity(0.3)
                }
                Spacer()
            }
        }
        .onAppear {
            imPrograssing = false
        }
        .onDisappear {
            dao.metaSelecionlada = selectedGoal
        }
    }
}

//#Preview {
//    EscolhaObjetivoView(selectedLevel: .constant(""))
//}
