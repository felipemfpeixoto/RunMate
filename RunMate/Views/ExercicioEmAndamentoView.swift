//
//  ExercícioEmAndamentoView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI

struct ExercicioEmAndamentoView: View {
    
    @EnvironmentObject var healthManager: HealthManager
    
    var stopWatchmanager =  StopWatchManager()
    
    @State var isRunning: Bool = false
    
    @State var isShowingAviso: Bool = false
    
    @State private var isSummaryViewActive = false
    
    @Binding var apareceParabensMeta: Bool
    
    @Binding var apareceParabens: Bool
    
    @Binding var isEditing: Bool
    
    @Binding var isShowingSelf: Bool
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blackBlue.ignoresSafeArea()
                VStack{
                    HStack{
                        Spacer()
                        Button {
                            isShowingSelf = false
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 30)
                    }
                    Spacer()
                    VStack{
                        //                    Text("Velocidade Média: \(healthManager.averageSpeed, specifier: "%.2f") km/h")
                        //                    Text("Calorias: \(healthManager.calories, specifier: "%d") kcal")
                        VStack{
                            Text("\(healthManager.distance, specifier: "%.2f")")
                                .font(.custom("Poppins-Bold", size: 115))
                                .foregroundStyle(.white)
                            Text("Quilômetros")
                                .font(.custom("Poppins-Bold", size: 28))
                                .foregroundStyle(.white)
                                .opacity(0.7)
                            Text("DISTÂNCIA")
                                .font(.custom("Poppins-Bold", size: 16))
                                .foregroundStyle(.turquoiseGreen)
                        }
                        .frame(width: 360, height: 303)
                        .background(Color.oceanBlue)
                        .cornerRadius(20)
                        
                        VStack(spacing: -9){
                            Text(stopWatchmanager.formattedTime)
                                .font(.custom("Poppins-Bold", size: 40))
                                .foregroundStyle(.white)
                            Text("DURAÇÃO")
                                .font(.custom("Poppins-Bold", size: 15))
                                .foregroundStyle(.turquoiseGreen)
                        }
                        .frame(width: 306, height: 95)
                        .background(Color.oceanBlue)
                        .cornerRadius(20)
                        .padding(.top, 29)
                        .padding(.bottom, 69)
                        
                    }
                    .font(Font.custom("Roboto-Regular", size: 20))
                    
                    HStack (spacing: 30){
                        Button(action: {
                            if healthManager.isRunning {
                                if healthManager.isPaused {
                                    healthManager.resumeWorkout()
                                    stopWatchmanager.start()
                                } else {
                                    healthManager.pauseWorkout()
                                    stopWatchmanager.pause()
                                }
                            } else {
                                healthManager.startWorkout()
                                stopWatchmanager.start()
                            }
                        }) {
                            let img = healthManager.isRunning ? (healthManager.isPaused ? "play.circle.fill" : "pause.circle.fill") : "play.circle.fill"
                            Image(systemName: img)
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            healthManager.endWorkout()
                            stopWatchmanager.stop()
                            isShowingAviso = true
                        }) {
                            Image(systemName: "stop.circle.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.white)
                        }
                        .disabled(!healthManager.isRunning)
                    }
                    Spacer()
                }
                .padding()
                
            }
            .overlay{
                if isShowingAviso{
                    ZStack{
                        Color.blackBlue.opacity(0.8)
                        withAnimation(Animation.spring(duration: 0.75)) {
                            AvisoConfirmacaoEtapa(apareceAtencao: $isShowingAviso, apareceParabensMeta: $apareceParabensMeta, apareceParabens: $apareceParabens, isEditing: $isEditing, isShowingExAndamento: $isShowingAviso, isSHowingSelf: $isShowingSelf)
                        }
                    }
                    
                }
            }
        }
    }
}

@Observable class StopWatchManager {
    var secondElapsed = 0.0
    var timer = Timer()
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
            self.secondElapsed += 0.01
        }
    }
    
    func stop() {
        timer.invalidate()
        secondElapsed = 0
    }
    
    func pause() {
        timer.invalidate()
    }
    
    var formattedTime: String {
        let hours = Int(secondElapsed) / 3600
        let minutes = (Int(secondElapsed) % 3600) / 60
        let seconds = Int(secondElapsed) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

