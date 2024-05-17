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
    
    @ObservedObject var stopWatchmanager =  StopWatchManager()
    
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
                
                if isRunning{
                    Button(action: {
                        isRunning = false
                        healthManager.stopCollectingData()
                        stopWatchmanager.pause()
                    }, label: {
                        Image(systemName: "pause.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
             
                    })
                }
                else{
                    Button(action: {
                        isRunning = true
                        healthManager.startCollectingData()
                        stopWatchmanager.start()
                    }, label: {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 70, height: 70)
                        
                    })
                }
                
                Button {
                    stopWatchmanager.stop()
                } label: {
                    Text("Finalizar corrida")
                        .foregroundStyle(.white)
                        .font(Font.custom("Roboto-Regular", size: 20))
                }

            }
        }
    }
}

class StopWatchManager: ObservableObject {
    @Published var secondElapsed = 0.0
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
