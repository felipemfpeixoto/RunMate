import SwiftUI

struct EscolhaNivelView: View {
    
    @State var isShowing: Bool = false
    
    @State var selectedLevel: String = ""
    
    @State var filenameLevel: String = ""
    
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
                            .frame(width: isShowing ? 96 : 0, height: 8)
                            .foregroundStyle(Color.turquoiseGreen)
                        Text("🏃🏻‍♂️")
                            .font(.system(size: 40))
                            .scaleEffect(x: -1, y: 1)
                            .padding(.leading, -20)
                        Spacer()
                    }
                }.frame(width: 320)
                Spacer()
                Text("Selecione seu nível de corredor:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                Spacer()
                BotaoEscolha(texto: "Iniciante", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                BotaoEscolha(texto: "Intermediário", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                BotaoEscolha(texto: "Avançado", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                Spacer()
                if selectedLevel != ""{
                    NavigationLink(destination: EscolhaObjetivoView(selectedLevel: $filenameLevel)) {
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
    }
}

#Preview {
    EscolhaNivelView()
}
