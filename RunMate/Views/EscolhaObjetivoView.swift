import SwiftUI

struct EscolhaObjetivoView: View {
    
    @Binding var faseBonequinho: Int
    
    @Binding var selectedLevel: String
    
    @State var selectedGoal: String = ""
    
    @State var filenameGoal: String = ""
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Selecione seu objetivo:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                Spacer()
                BotaoEscolha(texto: "5KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "10KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "15KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                Spacer()
                if selectedGoal != "" {
                    NavigationLink(destination: EscolhaIdadeView(selectedLevel: $selectedLevel, selectedGoal: $filenameGoal)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.turquoiseGreen)
                                .frame(width: 243, height: 56)
                            Text("Proximo")
                                .foregroundStyle(.black)
                                .font(.title3.bold())
                        }
                    }
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
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    EscolhaObjetivoView(selectedLevel: .constant(""))
//}
