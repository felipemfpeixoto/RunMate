import SwiftUI

struct EscolhaNivelView: View {
    
    @Binding var faseBonequinho: Int
    
    @State var selectedLevel: String = ""
    
    @Binding var filenameLevel: String
    
    @Binding var imProgressing: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione seu nível de corredor:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                BotaoEscolha(texto: "Iniciante", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                BotaoEscolha(texto: "Intermediário", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                BotaoEscolha(texto: "Avançado", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                Spacer()
                if selectedLevel != ""{
                    Button(action: {
                        self.imProgressing = true
                        faseBonequinho += 1
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
            imProgressing = true
        }
        .onDisappear {
            dao.nivelSelecionado = selectedLevel
        }
    }
}

//#Preview {
//    EscolhaNivelView()
//}
