////
////  HealthManager.swift
////  RunMate
////
////  Created by infra on 16/05/24.
////
//
//import Foundation
//import SwiftUI
//import HealthKit
//import Combine
//
//@Observable class HealthManager {
//
//    private var healthStore = HKHealthStore()
//
//    var averageSpeed: Double = 0.0
//    var calories: Double = 0.0
////    var distance: Double = 0.0
//    var isRunning: Bool = false
//    var isPaused: Bool = false
//
//    private var startTime: Date?
//    private var endTime: Date?
////    private var distanceAnchor: HKQueryAnchor?
//    
//    private var workoutBuilder: HKWorkoutBuilder?
//    private var workoutSession: HKWorkoutSession?
//    
//    init() {
//        let workoutConfiguration = HKWorkoutConfiguration()
//        workoutConfiguration.activityType = .other
//        workoutConfiguration.locationType = .unknown
//        
//        let speed = HKQuantityType(.runningSpeed)
//        let calories = HKQuantityType(.activeEnergyBurned)
//        workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: workoutConfiguration, device: .local())
//
//        workoutBuilder?.beginCollection(withStart: Date()) { (success, error) in
//            // Handle success or error
//        }
//        
//        requestAuthorization()
//    }
//
//    func stopCollectingData() {
//        endTime = Date()
//        fetchHealthData()
//    }
//
//    func startWorkout() {
//        isRunning = true
//        isPaused = false
//        startTime = Date()
//    }
//
//    func pauseWorkout() {
//        guard isRunning && !isPaused else { return }
//        isPaused = true
//        // Add any logic needed to pause the workout
//    }
//
//    func resumeWorkout() {
//        guard isRunning && isPaused else { return }
//        isPaused = false
//        // Add any logic needed to resume the workout
//    }
//
//    func endWorkout() {
//        isRunning = false
//        isPaused = false
//        workoutBuilder?.endCollection(withEnd: Date()) { (success, error) in
//            self.workoutBuilder?.finishWorkout { (workout, error) in
//                // Handle success or error on finishing the workout
//                self.stopCollectingData()
//            }
//        }
//    }
//
//    private func requestAuthorization() {
//        let typesToRead: Set<HKObjectType> = [
//            HKObjectType.workoutType(),
//            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!
//        ]
//
//        healthStore.requestAuthorization(toShare: [], read: typesToRead) { (success, error) in
//            if success {
//                print("Authorization succeeded.")
//            } else {
//                print("Authorization failed.")
//            }
//        }
//    }
//
//    private func fetchHealthData() {
//        let speedType = HKSampleType.quantityType(forIdentifier: .walkingSpeed)!
//        let caloriesType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
//        
////        fetchAverageSpeed()
//        fetchCalories(for: caloriesType, startTime: startTime!, endTime: endTime!)
//    }
//    
//    private func fetchAverageSpeed() {
//        guard let sampleType = HKQuantityType.quantityType(forIdentifier: .walkingSpeed) else {
//            print("Walking speed sample type is no longer available in HealthKit")
//            return
//        }
//        
//        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, statistics, error) in
//            if let error = error {
//                print("Error fetching statistics: \(error.localizedDescription)")
//                print("Descricao: \(error.asString)")
//                return
//            }
//            
//            guard let statistics = statistics else {
//                print("No statistics available")
//                return
//            }
//            
//            guard let quantity = statistics.averageQuantity() else {
//                print("No quantity available")
//                return
//            }
//            
//            DispatchQueue.main.async {
//                self.averageSpeed = quantity.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
//                print("Velocidade Média: ", self.averageSpeed)
//            }
//            print("Passou")
//        }
//        healthStore.execute(query)
//    }
//
//    private func fetchCalories(for sampleType: HKSampleType, startTime: Date, endTime: Date) {
//        let adjustedStartTime = startTime.addingTimeInterval(-3600)
//        let adjustedEndTime = endTime.addingTimeInterval(1)
//        
//        let testDate = Calendar.current.startOfDay(for: Date())
//        
//        let predicate = HKQuery.predicateForSamples(withStart: adjustedStartTime, end: adjustedEndTime)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
//            if let error = error {
//                print("Erro na consulta: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let statistics = statistics, let quantity = statistics.sumQuantity() else {
//                print("Não foi possível obter as estatísticas ou a quantidade.")
//                return
//            }
//            
//            self.calories = quantity.doubleValue(for: HKUnit.kilocalorie())
//            print("Calorias: ", self.calories)
//        }
//        self.healthStore.execute(query)
//    }
//    
//    private func fetchCalories2(for sampleType: HKSampleType, startTime: Date, endTime: Date) {
//        // Função para realizar uma consulta de calorias
//        func queryCalories(from startTime: Date, to endTime: Date, completion: @escaping (Double?) -> Void) {
//            let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime)
//            let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
//                if let error = error {
//                    print("Erro na consulta: \(error.localizedDescription)")
//                    completion(nil)
//                    return
//                }
//                
//                guard let statistics = statistics, let quantity = statistics.sumQuantity() else {
//                    print("Não foi possível obter as estatísticas ou a quantidade.")
//                    completion(nil)
//                    return
//                }
//                
//                let calories = quantity.doubleValue(for: HKUnit.kilocalorie())
//                completion(calories)
//            }
//            healthStore.execute(query)
//        }
//        
//        let previousStartTime = startTime.addingTimeInterval(-3600)
//        let previousEndTime = startTime
//        let currentEndTime = endTime.addingTimeInterval(1)
//        
//        // Realizar a consulta para a hora anterior ao exercício
//        queryCalories(from: previousStartTime, to: previousEndTime) { previousCalories in
//            guard let previousCalories = previousCalories else { return }
//            
//            // Realizar a consulta para o período do exercício
//            queryCalories(from: startTime, to: currentEndTime) { currentCalories in
//                guard let currentCalories = currentCalories else { return }
//                
//                // Calcular a diferença
//                let remainingCalories = currentCalories - previousCalories
//                DispatchQueue.main.async {
//                    self.calories = remainingCalories
//                    print("Calorias restantes: ", self.calories)
//                }
//            }
//        }
//    }
//
//}
//
