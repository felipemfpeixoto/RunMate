import SwiftUI
import PostHog

struct EscolhasCentral: View {
    
    @Binding var faseBonequinho: Int
    @Binding var filenameLevel: String
    @Binding var filenameGoal: String
    @Binding var value: Int
    @Binding var imProgressing: Bool
    @Binding var isEditing: Bool
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        if faseBonequinho > 1 {
                            withAnimation(.easeInOut(duration: 0.75)) {
                                self.imProgressing = false
                                faseBonequinho -= 1
                            }
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
                            .onDisappear {
                                PostHogSDK.shared.capture("Escolha Nível")
                            }
                            .onAppear {
                                PostHogSDK.shared.capture("Abriu o app pela primeira vez")
                            }
                        
                    } else if faseBonequinho == 2 {
                        EscolhaObjetivoView(faseBonequinho: $faseBonequinho, selectedLevel: $filenameLevel, filenameGoal: $filenameGoal, imPrograssing: $imProgressing)
                            .padding(.horizontal)
                            .onDisappear {
                                PostHogSDK.shared.capture("Escolha Meta")
                            }
                           
                    } else if faseBonequinho == 3 {
                        VStack {
                            EscolhaIdadeView(selectedLevel: $filenameLevel, selectedGoal: $filenameGoal, value: $value, imPrograssing: $imProgressing)
                                .padding(.horizontal)
                                .onDisappear {
                                    PostHogSDK.shared.capture("Escolha Idade")
                                }
                            Button {
                                withAnimation(.easeInOut(duration: 0.75)) {
                                    dao.idade = Double(value) + 16
                                    criaEscolhas()
                                    isEditing = false
                                }
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundStyle(Color.turquoiseGreen)
                                        .frame(width: 243, height: 56)
                                    HStack {
                                        Text("PRÓXIMO")
                                            .font(Font.custom("Poppins-SemiBold", size: 18))
                                            .foregroundStyle(Color.blackBlue)
                                          
                                        
                                        Image(systemName: "arrow.right")
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(.blackBlue)
                                           
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .frame(height: 450)
                .transition(AnyTransition.asymmetric(insertion: .move(edge: imProgressing ? .trailing : .leading), removal: .move(edge: imProgressing ? .leading : .trailing)))
                Spacer()
            }
        }
        .animation(.easeInOut(duration: 0.75), value: self.faseBonequinho)
        .onAppear {
            withAnimation(Animation.spring(duration: 0.5)) {
                faseBonequinho = 1
            }
        }
    }
    
    func criaEscolhas() {
        escolhas = MeuPlano(nivel: filenameLevel, objetivo: filenameGoal, idade: value)
        let nomeArquivo = filenameLevel + filenameGoal
        print(nomeArquivo)
        dao.loadJsonFileFromObjective()
    }
}
