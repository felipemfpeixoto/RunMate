import SwiftUI

struct ParabénsView: View {
    
    let gridItems = [GridItem(.fixed(150)), GridItem(.fixed(200))]
    let semana: Semana
    let index: Int
    
    @State var dadosSemana: DadosSemana?
    
    var body: some View {
        ZStack {
            Color.blackBlue
                .ignoresSafeArea()
            if dadosSemana == nil {
                ProgressView()
            } else {
                ScrollView {
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(semana.semana)ª Semana")
                                    .font(.custom("Poppins-SemiBold", size: 24))
                                    .foregroundStyle(.white)
                                Text("CONCLUÍDA")
                                    .font(.custom("Poppins-SemiBold", size: 18))
                                    .foregroundStyle(Color.lilacPurple)
                            }
                            Spacer()
                        }
                        ZStack {
                            VStack {
                                Text("PARABÉNS!")
                                    .font(.custom("Poppins-SemiBold", size: 18))
                                    .foregroundStyle(Color.darkPurple)
                                Spacer()
                                Text("Esta semana você queimou calorias equivalentes a 10 barras de chocolate")
                                    .multilineTextAlignment(.center)
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundStyle(Color.darkPurple)
                            }.padding(10)
                        }
                        .frame(height: 115)
                        .padding()
                        .background(Color.turquoiseGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                            Image("chocolate")
                                .alignmentGuide(HorizontalAlignment.trailing) { dimension in
                                    UIScreen.main.bounds.width * 0.30
                                }
                                .alignmentGuide(VerticalAlignment.top) { dimension in
                                    35
                                }
                        }
                        
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2)) {
                            ZStack {
                                Color.darkPurple
                                    .cornerRadius(15)
                                VStack {
                                    HStack(alignment: .top){
                                        Text("Velocidade Média")
                                            .multilineTextAlignment(.leading)
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Image("raio")
                                    }
                                    Spacer()
                                    HStack {
                                        Text("\(dadosSemana?.velocidadeMédia ?? 0) km/h")
                                            .font(.custom("Poppins-SemiBold", size: 26))
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }
                                }.padding()
                            }
                            ZStack {
                                Color.darkPurple
                                    .cornerRadius(15)
                                VStack {
                                    HStack(alignment: .top){
                                        Text("Calorias")
                                            .multilineTextAlignment(.leading)
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Image("fuego")
                                    }
                                    Spacer()
                                    HStack {
                                        Text("\(dadosSemana?.calorias ?? 0) kcal")
                                            .font(.custom("Poppins-SemiBold", size: 26))
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }
                                }.padding()
                            }
                            ZStack {
                                Color.darkPurple
                                    .cornerRadius(15)
                                VStack {
                                    HStack(alignment: .top){
                                        Text("Distância")
                                            .multilineTextAlignment(.leading)
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Image("bandeirinha")
                                    }
                                    Spacer()
                                    HStack {
                                        Text("\(dadosSemana?.distância ?? 0) km")
                                            .font(.custom("Poppins-SemiBold", size: 26))
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }
                                }.padding()
                            }
                            ZStack {
                                Color.darkPurple
                                    .cornerRadius(15)
                                VStack {
                                    HStack(alignment: .top){
                                        Text("Pace Médio")
                                            .multilineTextAlignment(.leading)
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundStyle(.white)
                                        Spacer()
                                        Image("corredor")
                                    }
                                    Spacer()
                                    HStack {
                                        Text("\(dadosSemana?.paceMedio ?? 0) minutos")
                                            .font(.custom("Poppins-SemiBold", size: 26))
                                            .foregroundStyle(.white)
                                        Spacer()
                                    }
                                }.padding()
                            }
                        }
                        
                        scrollViewHorizontal
                            .padding(.top)
                        contentView
                    }
                }
                .padding()
                .ignoresSafeArea()
            }
        }
        .onAppear {
            dadosSemana = dao.dadosSemanas[index]
        }
    }
    
    var contentView: some View {
        VStack {
            if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count > 0 {
                if dao.paginaDeTreinamento.planoDeTreinamento.semanas[index].dias[dao.diaAtual].exercicios.isEmpty {
                    diaLivre
                } else if (dao.semanaAtual + 1) == dao.paginaDeTreinamento.planoDeTreinamento.semanas.count && dao.diaAtual == 6 {
                    diaProva
                } else {
                    VStack {
                        ExerciciosDetalhadosView(exercicios: dao.paginaDeTreinamento.planoDeTreinamento.semanas[index].dias[dao.diaAtual].exercicios, isLocked: false, isOverview: true)
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
            }
        }
    }
    
    var diaLivre: some View {
        VStack {
            Text("DIA LIVRE")
                .font(.custom("Poppins-SemiBold", size: 30))
                .foregroundColor(.lakeBlue)
                .padding(.top, 30)
            Image("Cadeira")
                .resizable()
                .scaledToFit()
                .frame(width: 136, height: 133)
            Text("Tire uma folga do seu \ncronograma de corrida e \naproveite um dia de descanso!")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.lakeBlue)
                .multilineTextAlignment(.center)
            Spacer()
        }
    }
    
    var diaProva: some View {
        VStack {
            ZStack(alignment: .leading) {
                VStack {
                    LazyVGrid(columns: gridItems, alignment: .leading) {
                        Text(dao.metaSelecionlada)
                            .font(.custom("Poppins-SemiBold", size: 18))
                            .padding(.leading, 80)
                        
                        VStack(alignment: .leading) {
                            Text("Corrida Definitiva")
                                .font(.custom("Poppins-SemiBold", size: 15).bold())
                            Text("Distância final da meta")
                                .font(.custom("Poppins-Medium", size: 12))
                        }
                    }
                    .padding(.horizontal, 40)
                    .foregroundColor(.white)
                    .frame(width: 359, height: 65)
                }
                
                Text("1X")
                    .font(.custom("Poppins-Medium", size: 18))
                    .foregroundColor(.oceanBlue)
                    .frame(width: 63, height: 65)
                    .background(dao.diasConcluidos.contains(dao.diaAtual + 1) ?  Color.lilacPurple : Color.turquoiseGreen)
                    .cornerRadius(18)
            }
            .background(Color.oceanBlue)
            .cornerRadius(18)
            Spacer()
        }
        .padding(.vertical, 20)
    }
    
    var scrollViewHorizontal: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(semana.dias, id: \.dia) { dia in
                    let isEqual = dia.dia == (dao.diaAtual + 1)
                    let myButtonStyle = diaEstiloButton(isEqual: isEqual)

                    Button(action: {
                        if dia.dia != (dao.diaAtual + 1) {
                            self.updateDiaAtual(dia: dia)
                        }
                    }, label: {
                        diaLabel(dia: dia, isEqual: isEqual)
                    })
                    .buttonStyle(myButtonStyle)
                }
            }
            .padding(.leading, 10)
        }
        .padding(.leading, -10)
    }
    
    func diaEstiloButton(isEqual: Bool) -> some ButtonStyle {
        if isEqual {
            return AnyButtonStyle(BotaoDiaLilas())
        } else {
            return AnyButtonStyle(BotaoDia())
        }
    }
    
    func updateDiaAtual(dia: Dia) {
        if dia.dia == (dao.diaAtual + 1) {
            dao.diaAtual = dia.dia
        } else {
            dao.diaAtual = (dia.dia - 1)
        }
    }

    func diaLabel(dia: Dia, isEqual: Bool) -> some View {
        VStack {
            Text("\(dia.dia)º")
                .font(Font.custom("Roboto-Bold", size: 30))
            Text("Dia")
                .font(Font.custom("Roboto-Bold", size: 18))
        }
        .foregroundStyle(isEqual ? Color.oceanBlue : Color.white)
    }
}

//#Preview {
//    ParabénsView()
//}
