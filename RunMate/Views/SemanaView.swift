//
//  SemanaView.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct SemanaView: View {
    
    @State var semana: [Dia]?
    @State var apareceParabens: Bool = false
    @State var apareceInfo: Bool = false
    
    @State var isShowingAvisoConclusao = false
    
    @State var apareceParabensMeta = false
    
    let gridItems = [GridItem(.fixed(150)), GridItem(.fixed(200))]
   
    var body: some View {
        ZStack{
            Color(.blackBlue).ignoresSafeArea()
            
            if dao.semanaAtual == -1 {
                ProgressView()
            } else {
                VStack{
                    Spacer()
                    headerPrincipal
                    if dao.paginaDeTreinamento.planoDeTreinamento.semanas.count > 0 {
                        if dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias[dao.diaAtual].exercicios.isEmpty{
                            diaLivre
                        } 
                        else if (dao.semanaAtual + 1) == dao.paginaDeTreinamento.planoDeTreinamento.semanas.count && dao.diaAtual == 6{
                            diaProva
                        }
                        else {
                            VStack{
                                ExerciciosDetalhadosView(exercicios: dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias[dao.diaAtual].exercicios)
                                Spacer()
                            }
                            .padding(.vertical, 20)
                        }
                    }
                    Spacer()
                    if dao.diasConcluidos.contains(dao.diaAtual) || dao.diaAtual == 0 {
                        if dao.diasConcluidos.contains(dao.diaAtual + 1){
                            etapaConcluida
                        } else {
                            botaoEtapaNaoConcluida
                        }
                            
                        Spacer()
                    }
                }
                .onAppear {
                    print(dao.semanaAtual)
                    print(dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias)
                    semana = dao.paginaDeTreinamento.planoDeTreinamento.semanas[dao.semanaAtual].dias
                }
                .onChange(of: dao.semanaAtual) { oldValue, newValue in
                    print("semana = " + String(newValue))
                }
                .onChange(of: dao.diaAtual) { oldValue, newValue in
                    print("dia = " + String(newValue))
                }
            }
        }
        .navigationBarBackButtonHidden()
        .overlay{
            if apareceParabens {
                ZStack{
                    Color.black.opacity(0.3).ignoresSafeArea()
                    ParabénsView(apareceParabens: $apareceParabens)
                }
            } else if isShowingAvisoConclusao {
                Color.black.opacity(0.3).ignoresSafeArea()
                AvisoConfirmacaoEtapa(apareceAtencao: $isShowingAvisoConclusao, apareceParabensMeta: $apareceParabensMeta, apareceParabens: $apareceParabens)
                
            }
        }
        .sheet(isPresented: $apareceInfo){
            SemanaConcluidaView(apareceInfo: $apareceInfo)
        }
        .fullScreenCover(isPresented: $apareceParabensMeta, content: {
            ConclusaoMetaView()
        })
    }
    
    var minhaMeta: some View {
        VStack(alignment: .leading){
            Text("Minha meta")
                    .font(Font.custom("Roboto-Bold", size: 28))
                    .foregroundStyle(Color.white)
            
            Text("\(dao.metaSelecionlada == "5KM" ? String(dao.metaSelecionlada.prefix(1)) : String(dao.metaSelecionlada.prefix(2))) km - \(dao.nivelSelecionado)")
                .font(Font.custom("Roboto-Regular", size: 24))
                .foregroundStyle(Color.turquoiseGreen)
                .padding(.bottom, 30)
        }
    }
    
    var botoesFuncionais: some View {
        HStack{
//            NavigationLink(destination: RoadMapView(), label: {
//                Text(Image(systemName: "figure.run.circle.fill"))
//                    .foregroundStyle(Color.turquoiseGreen)
//                    .font(.system(size: 30))})
            Button {
                apareceInfo = true
            } label: {
                Text(Image(systemName: "info.circle"))
                    .foregroundStyle(Color.turquoiseGreen)
                    .font(.system(size: 30))
                    .fontWeight(.light)
                    .padding(.leading, 50)
                  
            }
            
            
            NavigationLink(destination: RoadMapView(), label: {
                Text(Image(systemName: "figure.run.circle.fill"))
                    .foregroundStyle(Color.turquoiseGreen)
                    .font(.system(size: 30))})
        }
        .padding(.trailing, 15)
    }
    
    var headerPrincipal: some View {
        VStack(alignment: .leading) {
            HStack (alignment: .top) {
                minhaMeta
                Spacer()
                NavigationLink(destination: ContentView(isEditing: true, isShowingAviso: .constant(true))) {
                    Text("Resetar escolhas")
                }
                Spacer()
                botoesFuncionais
            }
            Text("\(dao.semanaAtual+1)ª semana")
                .font(Font.custom("Roboto-Bold", size: 24))
                .foregroundStyle(Color.white)
            scrollViewHorizontal
        }
        .padding(.leading)
        .padding(.top, 40)
    }
    
    var etapaConcluida: some View {
        HStack{
            Text("ETAPA CONCLUÍDA")
                .font(Font.custom("Poppins-SemiBold", size: 18))
                .foregroundStyle(Color.white)
            Text(Image(systemName: "checkmark.seal.fill"))
                .foregroundStyle(Color.darkPurple)
                .font(.system(size: 20))
        }
        .padding(10)
        .frame(width: 243, height: 43, alignment: .center)
        .background(Color.lilacPurple)
        .cornerRadius(11)
        .padding(.bottom, 10)
    }
    
    var botaoEtapaNaoConcluida: some View {
        VStack{
            Button(action: {
                withAnimation(Animation.spring(duration: 0.75)) {
                    isShowingAvisoConclusao.toggle()
                }
            }, label: {
                Text("CONCLUIR ETAPA")
                    .font(Font.custom("Poppins-SemiBold", size: 18))
                    .foregroundStyle(Color.white)
                Text(Image(systemName: "checkmark.seal.fill"))
                    .foregroundStyle(Color.turquoiseGreen)
                    .font(.system(size: 20))
            })
            .padding(10)
            .frame(width: 243, height: 43, alignment: .center)
            .background(Color.oceanBlue)
            .cornerRadius(11)
        }
        .padding(.bottom, 10)
    }
    
    var scrollViewHorizontal: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(semana ?? [], id: \.dia) { dia in
                    let isEqual = dia.dia == (dao.diaAtual + 1)
                    let myButtonStyle = diaEstiloButton(isEqual: isEqual, diaConcluido: dao.diasConcluidos.contains(dia.dia))

                    Button(action: {
                        if dia.dia != (dao.diaAtual + 1) {
                            self.updateDiaAtual(dia: dia)
                        }
                    }, label: {
                        diaLabel(dia: dia, isEqual: isEqual)
                    })
                    .buttonStyle(myButtonStyle)
                }
            }.padding(.leading, 10)
        }.padding(.leading, -10)
    }

    var diaLivre: some View {
        VStack{
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
        VStack{
            ZStack(alignment: .leading){
                VStack{
                    LazyVGrid(columns: gridItems, alignment: .leading) {
                        Text(dao.metaSelecionlada)
                            .font(.custom("Poppins-SemiBold", size: 18))
                            .padding(.leading, 80)
                        
                        VStack(alignment: .leading){
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

    func diaEstiloButton(isEqual: Bool, diaConcluido: Bool) -> some ButtonStyle {
        if diaConcluido {
            if isEqual {
                return AnyButtonStyle(BotaoDiaLilas())
            } else {
                return AnyButtonStyle(BotaoDiaDarkPurple())
            }
        } else {
            if isEqual {
                return AnyButtonStyle(BotaoDiaTurquesa())
            } else {
                return AnyButtonStyle(BotaoDia())
            }
        }
    }

}

#Preview {
    SemanaView(semana: dao.paginaDeTreinamento.planoDeTreinamento.semanas.first!.dias)
}
