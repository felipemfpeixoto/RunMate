import SwiftUI

struct SemanaConcluidaView: View {
    
    @Binding var isShowing: Bool
    
    let semana: Semana
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(semana.semana)ª Semana")
                            .font(.title.bold())
                            .foregroundStyle(.white)
                        Text("CONCLUÍDA")
                            .foregroundStyle(.lilacPurple)
                    }
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 150)
                        .foregroundStyle(.lilacPurple)
                    VStack {
                        Spacer()
                        Text("PARABÉNS!")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                        Spacer()
                        Text("Esta semana você queimou calorias equivalentes a 10 barras de chocolate")
                            .font(.body.bold())
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width * 0.85, height: 150)
                }
                .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    Image("chocolate")
                        .alignmentGuide(HorizontalAlignment.trailing) { dimension in
                            UIScreen.main.bounds.width * 0.25
                        }
                        .alignmentGuide(VerticalAlignment.top) { dimension in
                            50
                        }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SemanaConcluidaView(isShowing: .constant(true), semana: Semana(semana: 1, dias: []))
}
