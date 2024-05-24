import SwiftUI
import PostHog

struct EscolhaNivelView: View {
    
    @Binding var faseBonequinho: Int
    @State var selectedLevel: String = ""
    @Binding var filenameLevel: String
    @Binding var imProgressing: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione seu nível de corredor:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                    .font(Font.custom("Roboto-Regular", size: 22))
                BotaoEscolha(texto: "Iniciante", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                BotaoEscolha(texto: "Intermediário", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                BotaoEscolha(texto: "Avançado", selectedLevel: $selectedLevel, reallySelectedLevel: $filenameLevel)
                
                Spacer()
                
                VStack {
                    Text(dao.nivelDescricao)
                        .foregroundStyle(.white)
                        .font(Font.custom("Roboto-Regular", size: 14))
                        .multilineTextAlignment(.center)
                }.frame(width: 300, height: 100)
                
                Spacer()
                if selectedLevel != "" {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.75)) {
                            self.imProgressing = true
                            faseBonequinho += 1
                            PostHogSDK.shared.capture("NivelSelecionado", properties: ["nivel": filenameLevel])
                        }
                    }, label: {
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
                    })
                } else {
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
                    .opacity(0.3)
                }
                Spacer()
            }
        }
        .onAppear {
            imProgressing = true
        }
        .onDisappear {
            dao.nivelSelecionado = selectedLevel
        }
    }
}
