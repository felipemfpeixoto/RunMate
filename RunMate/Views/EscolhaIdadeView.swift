import SwiftUI

struct EscolhaIdadeView: View {

    
    @State var isShowing: Bool = false
    
    @Binding var selectedLevel: String
    
    @Binding var selectedGoal: String
    
    @Binding var value: Int
    
    @Binding var imPrograssing: Bool
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("Selecione sua idade:")
                    .foregroundStyle(.white)
                    .font(.title3.bold())
                
                VStack {
                    Picker("Selecione sua idade", selection: $value) {
                        ForEach(16..<100) { number in
                            Text("\(number)")
                                .tag("\(number)")
                                .foregroundStyle(.white)
                        }
                    }
                    .pickerStyle(.wheel)
                    .background(Color.oceanBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 20)
                }
                Spacer()
                VStack{}.frame(height: 100)
            }
        }
        .onDisappear {
            print(value)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2)) {
                isShowing = true
            }
            imPrograssing = false
        }
    }
    
}

