import SwiftUI

struct EscolhaIdadeView: View {
    
    @State var isShowing: Bool = false
    
    @State var isShowingPopup: Bool = false
    
    @Binding var selectedLevel: String
    
    @Binding var selectedGoal: String
    
    @State var value: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione sua idade:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                
                VStack {
                    Picker("Selecione sua idadde", selection: $value) {
                        ForEach(0..<100) { number in
                            Text("\(number)")
                                .tag("\(number)")
                                .foregroundStyle(.white)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(Color.oceanBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                Spacer()
                if value != 0 {
                    NavigationLink(destination: SemanaView()) {
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
            withAnimation(Animation.easeInOut(duration: 2)) {
                isShowing = true
            }
        }
        .onDisappear {
            dao.idade = value
            criaEscolhas()
        }
    }
    
    func criaEscolhas() {
        escolhas = MeuPlano(nivel: selectedLevel, objetivo: selectedGoal, idade: value)
        let nomeArquivo = selectedLevel + selectedGoal
        print(nomeArquivo)
        dao.loadJsonFileFromObjective()
    }
}

struct EscolheIdadeSheet: View {
    
    @Binding var isShowingPopup: Bool
    
    @Binding var value: Int
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            VStack {
                Picker("Selecione sua idadde", selection: $value) {
                    ForEach(0..<100) { number in
                        Text("\(number)")
                            .tag("\(number)")
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.wheel)
                .background(Color.oceanBlue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: {
                    isShowingPopup.toggle()
                }, label: {
                    Text("Confirmar")
                })
            }
        }
    }
}

#Preview {
    EscolhaIdadeView(selectedLevel: .constant(""), selectedGoal: .constant(""))
}
