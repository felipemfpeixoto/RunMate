import SwiftUI

struct EscolhaIdadeView: View {
    
    @State var isShowing: Bool = false
    
//    @State var isShowingPopup: Bool = false
    
    @Binding var selectedLevel: String
    
    @Binding var selectedGoal: String
    
    @Binding var value: Int
    
    @Binding var imPrograssing: Bool
    
    @Binding var isShowingPopUp: Bool
    
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
                    Button(action: {
                        isShowingPopUp = true
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(Color.turquoiseGreen)
                                .frame(width: 243, height: 56)
                            Text("Próximo")
                                .foregroundStyle(.black)
                                .font(.title3.bold())
                        }
                    })
//                    NavigationLink(destination: SemanaView()) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 20)
//                                .foregroundStyle(Color.turquoiseGreen)
//                                .frame(width: 243, height: 56)
//                            Text("Próximo")
//                                .foregroundStyle(.black)
//                                .font(.title3.bold())
//                        }
//                    }
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(Color.turquoiseGreen)
                            .frame(width: 243, height: 56)
                        Text("Próximo")
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
            imPrograssing = false
        }
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
            .padding()
        }
    }
}

//#Preview {
//    EscolhaIdadeView(selectedLevel: .constant(""), selectedGoal: .constant(""))
//}
