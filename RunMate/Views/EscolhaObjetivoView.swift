import SwiftUI

struct EscolhaObjetivoView: View {
    
    @Binding var faseBonequinho: Int
    
    @Binding var selectedLevel: String
    
    @State var selectedGoal: String = ""
    
    @Binding var filenameGoal: String
    
    @Binding var imPrograssing: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione seu objetivo:")
                    .foregroundStyle(.white)
                    .font(Font.custom("Roboto-Regular", size: 22))
                BotaoEscolha(texto: "5 km", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "10 km", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                BotaoEscolha(texto: "15 km", selectedLevel: $selectedGoal, reallySelectedLevel: $filenameGoal)
                Spacer()
                
                VStack{}.frame(height: 100)
                
                if selectedGoal != "" {
                    Button(action: {
                        imPrograssing = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            faseBonequinho += 1
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
            imPrograssing = false
        }
        .onDisappear {
            dao.metaSelecionlada = selectedGoal
        }
        
    }
}


