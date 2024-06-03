//
//  ExercícioEmAndamentoView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI
import PostHog
import CoreMotion

struct ExercicioEmAndamentoView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @State var stopWatchManager =  StopWatchManager()
    
    @State var isRunning: Bool = false
    
    @State var isShowingAviso: Bool = false
    
    @State private var isSummaryViewActive = false
    
    @Binding var apareceParabensMeta: Bool
    
    @Binding var apareceParabens: Bool
    
    @Binding var isEditing: Bool
    
    @Binding var isShowingSelf: Bool
    
    @State var locationManager = LocationManager()
    
    @State var calDiaria: Double = 0
    @State var distDiaria: Double = 0
    @State var velDiaria: Double = 0
    
    @State var lastSavedDate: Date = Date()
    @State var previousSavedDate: Date? = nil
    
    var exercicios: [Exercicio]
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blackBlue.ignoresSafeArea()
                VStack{
                    HStack{
                        Spacer()
                        
                        if !locationManager.isRunning {
                            Button {
                                isShowingSelf = false
                            } label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 30)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                    ScrollView(.vertical) {
                    VStack {
                        VStack {
                            Text("\(locationManager.distance, specifier: "%.2f")")
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
                            Text(stopWatchManager.formattedTime)
                                .font(.custom("Poppins-Bold", size: 40))
                                .foregroundStyle(.white)
                            Text("DURAÇÃO")
                                .font(.custom("Poppins-Bold", size: 15))
                                .foregroundStyle(.turquoiseGreen)
                            
                            
                        }
                        .frame(width: 306, height: 95)
                        .background(Color.oceanBlue)
                        .cornerRadius(20)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        
                        
                        
                            VStack {
                                ExerciciosDetalhadosView(exercicios: exercicios, isLocked: false, isOverview: false)
                            }
                            .padding(.bottom, 20)
                        
//                        .overlay(
//                                   LinearGradient(
//                                       gradient: Gradient(colors: [.clear, .blackBlue]),
//                                       startPoint: .top,
//                                       endPoint: .bottom
//                                   )
//                                   .edgesIgnoringSafeArea(.all)
//                               )
                        
                    }
                    }
                    .font(Font.custom("Roboto-Regular", size: 20))
                    .overlay(alignment: .bottom) {
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .blackBlue]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .edgesIgnoringSafeArea(.all)
                        .allowsHitTesting(false)
                        .frame(height: 100)
                    }
                    
                    HStack (spacing: 30){
                        Button(action: {
                            if locationManager.isRunning {
                                if locationManager.isPaused {
                                    locationManager.resumeCollectingLocations()
                                    stopWatchManager.start()
                                    locationManager.isRunning = true
                                } else {
                                    stopWatchManager.pause()
                                    locationManager.isRunning = false
                                    locationManager.isPaused = true
                                    PostHogSDK.shared.capture("Pausou Exercício")
                                }
                            } else {
                                stopWatchManager.start()
                                locationManager.isRunning = true
                                PostHogSDK.shared.capture("Começou Exercício")
                            }
                        }) {
                            let img = locationManager.isRunning ? (locationManager.isPaused ? "play.circle.fill" : "pause.circle.fill") : "play.circle.fill"
                            Image(systemName: img)
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
//                            calDiaria = healthManager.calories
//                            velDiaria = healthManager.averageSpeed
//                            distDiaria = locationManager.distance
                            isShowingAviso = true
                            PostHogSDK.shared.capture("Terminou Exercício")
                        }) {
                            Image(systemName: "stop.circle.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.white)
                        }
                        .disabled(!locationManager.isRunning)
                    }
                }
                .padding()
                
            }
            .fullScreenCover(isPresented: $isShowingAviso) {
                ZStack {
                    Color.blackBlue.opacity(0.8)
                        .ignoresSafeArea()
                    withAnimation(Animation.spring(duration: 0.75)) {
                        AvisoConfirmacaoEtapa(apareceAtencao: $isShowingAviso, apareceParabensMeta: $apareceParabensMeta, apareceParabens: $apareceParabens, isEditing: $isEditing, isShowingExAndamento: $isShowingAviso, isSHowingSelf: $isShowingSelf, calDiaria: $calDiaria, distDiaria: $distDiaria, velDiaria: $velDiaria, locationManager: $locationManager, stopWatchManager: $stopWatchManager, tempoMinutos: stopWatchManager.timeInMinutes)
                    }
                }
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                let lastDate = self.lastSavedDate
                if lastDate != self.previousSavedDate {
                    let difference = Date.now.timeIntervalSince(lastDate)
                    stopWatchManager.secondElapsed += difference
                    self.previousSavedDate = lastDate
                }
                print("active")
            } else if newPhase == .background {
                self.lastSavedDate = Date.now
                print("background")
                print(lastSavedDate.description)
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
    
    var timeInMinutes: Int {
        let minutes = (Int(secondElapsed) % 3600) / 60
        return minutes
    }
}
