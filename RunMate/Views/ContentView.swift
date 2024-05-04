import SwiftUI

enum Nivel {
    case iniciante, intermediario, avancado
}

enum Objetivo {
    case menor, medio, maior
}

var escolhas: MeuPlano? = nil

struct ContentView: View {
    
    @State var faseBonequinho: Int = 0
    
    @State var filenameLevel: String = ""
    
    @State var filenameGoal: String = ""
    
    var backslide: AnyTransition {
            AnyTransition.asymmetric(
                insertion: .move(edge: .trailing),
                removal: .move(edge: .leading))}
    
    var body: some View {
        NavigationStack {
            if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count == 0 {
                ZStack {
                    Color.blackBlue
                        .ignoresSafeArea()
                    VStack {
                        BonequinhoView(faseBonequinho: $faseBonequinho)
                        Group {
                            if faseBonequinho == 0 || faseBonequinho == 1 {
                                EscolhaNivelView(faseBonequinho: $faseBonequinho, filenameLevel: $filenameLevel)
                                    .transition(self.backslide)
                                    .padding(.horizontal)
                            } else if faseBonequinho == 2 {
                                EscolhaObjetivoView(faseBonequinho: $faseBonequinho, selectedLevel: $filenameLevel, filenameGoal: $filenameGoal)
                                    .transition(self.backslide)
                                    .padding(.horizontal)
                            } else if faseBonequinho == 3 {
                                EscolhaIdadeView(selectedLevel: $filenameLevel, selectedGoal: $filenameGoal)
                                    .transition(self.backslide)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 450)
                    }
                }
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 0.75)) {
                        faseBonequinho = 1
                    }
                }
            } else {
                SemanaView(semana: semanas[semanaAtual].dias)
            }
        }
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
                    Text("🏃🏻‍♂️")
                        .font(.system(size: 40))
                        .scaleEffect(x: -1, y: 1)
                        .padding(.horizontal, -20)
                    Spacer()
                }
            }.frame(width: 320)
        }
    }
}

#Preview {
    ContentView()
}
