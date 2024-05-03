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
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blackBlue
                    .ignoresSafeArea()
                VStack {
                    BonequinhoView(faseBonequinho: $faseBonequinho)
                    if faseBonequinho == 0 {
                        EscolhaNivelView(faseBonequinho: $faseBonequinho, filenameLevel: $filenameLevel)
                            .transition(.move(edge: .trailing))
                    } else if faseBonequinho == 1 {
                        EscolhaObjetivoView(faseBonequinho: $faseBonequinho, selectedLevel: <#T##Binding<String>#>)
                    }
                }
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
