import SwiftUI

var escolhas: MeuPlano? = nil

struct ContentView: View {
    
    @State var faseBonequinho: Int = 0
    
    @State var filenameLevel: String = ""
    
    @State var filenameGoal: String = ""
    
    @State var value: Int = 0
    
    @State var isShowingPopUp = false
    
    
    @State var backslide: AnyTransition = AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    @State var voltando: AnyTransition = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing))
    
    let tamanhoTela = UIScreen.main.bounds.width
    
    @State var telaAtual: Int = 0
    @State var imProgressing: Bool = true
    
    var body: some View {
            NavigationStack {
            if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count == 0 {
                ZStack {
                    Color.blackBlue
                        .ignoresSafeArea()
                    VStack {
                        HStack {
                            Button {
                                if faseBonequinho > 1 {
                                    self.imProgressing = false
                                    faseBonequinho -= 1
                                }
                            } label: {
                                Image(systemName: "arrow.left")
                                    .fontWeight(.bold)
                                    .font(.title)
                            }
                            .foregroundStyle(faseBonequinho > 1 ? .white : Color.blackBlue)
                            .padding()
                            
                            Spacer()
                        }
                        Spacer()
                        BonequinhoView(faseBonequinho: $faseBonequinho)
                        Spacer()
                        Group {
                            if faseBonequinho == 0 || faseBonequinho == 1 {
                                EscolhaNivelView(faseBonequinho: $faseBonequinho, filenameLevel: $filenameLevel, imProgressing: $imProgressing)
                                    .padding(.horizontal)
                                
                            } else if faseBonequinho == 2 {
                                EscolhaObjetivoView(faseBonequinho: $faseBonequinho, selectedLevel: $filenameLevel, filenameGoal: $filenameGoal, imPrograssing: $imProgressing)
                                    .padding(.horizontal)
                                   
                            } else if faseBonequinho == 3 {
                                EscolhaIdadeView(selectedLevel: $filenameLevel, selectedGoal: $filenameGoal, value: $value, imPrograssing: $imProgressing)
                                    .padding(.horizontal)
                                    
                            }
                        }
                        .frame(height: 450)
                        .transition(AnyTransition.asymmetric(insertion:.move(edge: imProgressing ? .trailing : .leading), removal: .move(edge: imProgressing ? .leading : .trailing)))
                        Spacer()
                    }
                }
                .animation(.easeInOut(duration: 0.75), value: self.faseBonequinho)
                .onAppear {
                    withAnimation(Animation.spring(duration: 0.5)) {
                        faseBonequinho = 1
                    }
                }
                .onDisappear {
                    dao.idade = Double(value) + 16
                    criaEscolhas()
                }

            } else {
                
                SemanaView(semana: dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias)
            }
        }.navigationBarBackButtonHidden()
    }
    
    func criaEscolhas() {
        escolhas = MeuPlano(nivel: filenameLevel, objetivo: filenameGoal, idade: value)
        let nomeArquivo = filenameLevel + filenameGoal
        print(nomeArquivo)
        dao.loadJsonFileFromObjective()
    }
}

struct BonequinhoView: View {
    
    @Binding var faseBonequinho: Int
    
    var body: some View {
        VStack {
            Text("Bora traçar nossa meta!")
                .foregroundStyle(.white)
                .font(.title.bold())
            ZStack {
                RoundedRectangle(cornerRadius: 100)
                    .frame(width: 320, height: 8)
                    .foregroundStyle(Color.oceanBlue)
                HStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 100)
                        .frame(width: CGFloat(faseBonequinho) * 103.33, height: 8)
                        .foregroundStyle(Color.turquoiseGreen)
                    ZStack {
                        Circle()
                            .foregroundStyle(Color.turquoiseGreen)
                            .frame(width: 40, height: 40)
                        Image(systemName: "figure.run")
                            .font(.system(size: 25))
                            .foregroundStyle(.blackBlue)
                    }
                    .padding(.horizontal, -15)
                    Spacer()
                }
            }.frame(width: 320)
        }
    }
}


