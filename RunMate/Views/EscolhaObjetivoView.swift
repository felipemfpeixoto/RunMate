import SwiftUI

struct EscolhaObjetivoView: View {
    
    @State var isShowing: Bool = false
    
    @Binding var selectedLevel: String
    
    @State var selectedGoal: String = ""
    
    @State var filenameGoal: String = ""
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Bora traçar nossa meta!")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                ZStack {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: 320, height: 8)
                        .foregroundStyle(Color.oceanBlue)
                    HStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 100)
                            .frame(width: isShowing ? 179 : 0, height: 8)
                            .foregroundStyle(Color.turquoiseGreen)
                        Text("🏃🏻‍♂️")
                            .font(.system(size: 40))
                            .scaleEffect(x: -1, y: 1)
                            .padding(.leading, -20)
                        Spacer()
                    }
                }.frame(width: 320)
                Spacer()
                Text("Selecione seu objetivo:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                Spacer()
                BotaoEscolha(texto: "5KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "10KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "15KM", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                Spacer()
                if selectedLevel != "" {
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
        .onAppear {
            withAnimation(.easeInOut(duration: 2)) {
                isShowing = true
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EscolhaObjetivoView(selectedLevel: .constant(""))
}
