//
//  ExercícioEmAndamentoView.swift
//  RunMate
//
//  Created by Giovana Nogueira on 17/05/24.
//

import SwiftUI

struct ExercicioEmAndamentoView: View {
    
    @State var isRunning: Bool = false
    
    @EnvironmentObject var healthManager: HealthManager
    
    
    var stopWatchmanager =  StopWatchManager()
    
    @State private var isSummaryViewActive = false
    
    var body: some View {
        ZStack{
            Color.blackBlue.ignoresSafeArea()
            VStack{
                
                VStack{
                    Text("Velocidade Média: \(healthManager.averageSpeed, specifier: "%.2f") km/h")
                    Text("Calorias: \(healthManager.calories, specifier: "%d") kcal")
                    Text("Distância: \(healthManager.distance, specifier: "%.2f") km")
                    Text(stopWatchmanager.formattedTime)
                }
                .foregroundColor(.white)
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
                        var img = healthManager.isRunning ? (healthManager.isPaused ? "play.circle" : "pause.circle") : "play.circle"
                        Image(systemName: img)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    
                    Button(action: {
                        healthManager.endWorkout()
                        stopWatchmanager.stop()
                    }) {
                        Image(systemName: "stop.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    .disabled(!healthManager.isRunning)
                }
            }
            .padding()

        }
//        .onAppear{
//            if isRunning{
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                    workoutManager.stopWorkout()
//                }
//            }
//        }
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
