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
    
    @State var isEditing: Bool
    
    @Binding var isShowingAviso: Bool
    
    var body: some View {
            NavigationStack {
//            if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count == 0 || isEditing {
                EscolhasCentral(faseBonequinho: $faseBonequinho, filenameLevel: $filenameLevel, filenameGoal: $filenameGoal, value: $value, imProgressing: $imProgressing)
                    .onAppear {
                        isShowingAviso.toggle()
                    }
//            } else {
//                TelaTabView()
//                SemanaView(semana: dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias)
//            }
        }.navigationBarBackButtonHidden()
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


