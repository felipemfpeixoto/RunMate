import SwiftUI

struct EscolhaIdadeView: View {
    
    @State var isShowing: Bool = false
    
    @State var isShowingPopup: Bool = false
    
    @Binding var selectedLevel: String
    
    @Binding var selectedGoal: String
    
    @State var value: Int = 0
    
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
                Text("Selecione sua idade:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                Button(action: {
                    isShowingPopup = true
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 321, height: 53)
                            .foregroundStyle(Color.oceanBlue)
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 316, height: 48)
                            .foregroundStyle(Color.blackBlue)
                        Text("\(value)")
                            .foregroundStyle(Color.turquoiseGreen)
                    }
                })
                
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
            isShowing = true
        }
        .sheet(isPresented: $isShowingPopup, content: {
            VStack {
                Picker("Selecione sua idadde", selection: $value) {
                    ForEach(0..<100) { number in
                        Text("\(number)")
                            .tag("\(number)")
                            .foregroundStyle(.black)
                    }
                }
                .pickerStyle(.wheel)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Button(action: {
                    isShowingPopup.toggle()
                }, label: {
                    Text("Confirmar")
                })
            }
        })
        .navigationBarBackButtonHidden()
        .onDisappear {
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

#Preview {
    EscolhaIdadeView(selectedLevel: .constant(""), selectedGoal: .constant(""))
}
