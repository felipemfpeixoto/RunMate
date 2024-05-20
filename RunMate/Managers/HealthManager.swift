//
//  HealthManager.swift
//  RunMate
//
//  Created by infra on 16/05/24.
//

import Foundation
import SwiftUI
import HealthKit

//@Observable class HealthManager {
//    
//    init() {
//        let runningSpeed = HKQuantityType(.runningSpeed)
//        let walkingSpeed = HKQuantityType(.walkingSpeed)
//        let calories = HKQuantityType(.activeEnergyBurned)
//        let distance = HKQuantityType(.distanceWalkingRunning)
//        
//        Task {
//            do {
//                
//            } catch {
//                
//            }
//        }
//    }
    
//    func fetchTodayCalories() {
//        let calories = HKQuantityType(.activeEnergyBurned)
//        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
//        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
//            guard let quantity = result?.sumQuantity(), error == nil else{
//                print("error fetching todays calories data")
//                return
//            }
//            let caloriesBurned = quantity.doubleValue(for: .kilocalorie())
//            let activity = Activity(id: 0, title: "Today Calories", subtitle: "Goal 900", image: "flame", amount: caloriesBurned.formattedString())
//            
//            DispatchQueue.main.async {
//                self.activities["todayCalories"] = activity
//            }
//            
//            print(caloriesBurned.formattedString())
//        }
//        
//        healthStore.execute(query)
//    }
    
//}

//#Preview {
//    HealthViewTeste()
//}

//struct HealthViewTeste: View {
//    private var healthStore = HKHealthStore()
//    
//    @State private var averageSpeed: Double = 0.0
//    @State private var calories: Double = 0.0
//    @State private var distance: Double = 0.0
//    
//    var body: some View {
//        VStack {
//            Text("Velocidade Média: \(averageSpeed, specifier: "%.2f") km/h")
//            Text("Calorias: \(calories, specifier: "%.2f") kcal")
//            Text("Distância: \(distance, specifier: "%.2f") km")
//                .onAppear(perform: requestAuthorization)
//        }
//        .padding()
//    }
//    
//    private func requestAuthorization() {
//        let typesToRead: Set<HKObjectType> = [
//            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
//            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
//            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!
//        ]
//        
//        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
//            if success {
//                fetchHealthData()
//            } else {
//                print("Authorization failed.")
//            }
//        }
//    }
//    
//    private func fetchHealthData() {
//        let speedType = HKSampleType.quantityType(forIdentifier: .walkingSpeed)!
//        let caloriesType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
//        let distanceType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!
//        
//        fetchAverageSpeed(for: speedType)
//        fetchCalories(for: caloriesType)
//        fetchDistance(for: distanceType)
//    }
//    
//    private func fetchAverageSpeed(for sampleType: HKSampleType) {
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, statistics, error) in
//            guard let statistics = statistics, let quantity = statistics.averageQuantity() else { return }
//            DispatchQueue.main.async {
//                self.averageSpeed = quantity.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//    
//    private func fetchCalories(for sampleType: HKSampleType) {
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
//            guard let statistics = statistics, let quantity = statistics.sumQuantity() else { return }
//            DispatchQueue.main.async {
//                self.calories = quantity.doubleValue(for: HKUnit.kilocalorie())
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//    
//    private func fetchDistance(for sampleType: HKSampleType) {
//        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
//            guard let statistics = statistics, let quantity = statistics.sumQuantity() else { return }
//            DispatchQueue.main.async {
//                self.distance = quantity.doubleValue(for: HKUnit.meter()) / 1000 // Convert meters to kilometers
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//}


//@Observable class HealthManager {
//    
//    private var healthStore = HKHealthStore()
//    
//    var averageSpeed: Double = 0.0
//    var calories: Double = 0.0
//    var distance: Double = 0.0
//    
//    var session: HKWorkoutSession?
//    
//    private var startTime: Date?
//    private var endTime: Date?
//    
//    func startCollectingData() {
//        startTime = Date()
//        requestAuthorization()
//    }
//    
//    func stopCollectingData() {
//        endTime = Date()
//        fetchHealthData()
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
//        guard let startTime = startTime, let endTime = endTime else { return }
//        
//        let speedType = HKSampleType.quantityType(forIdentifier: .walkingSpeed)!
//        let caloriesType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
//        let distanceType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!
//        
//        fetchAverageSpeed(for: speedType, startTime: startTime, endTime: endTime)
//        fetchCalories(for: caloriesType, startTime: startTime, endTime: endTime)
//        fetchDistance(for: distanceType, startTime: startTime, endTime: endTime)
//    }
//    
//    private func fetchAverageSpeed(for sampleType: HKSampleType, startTime: Date, endTime: Date) {
//        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: .strictEndDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, statistics, error) in
//            guard let statistics = statistics, let quantity = statistics.averageQuantity() else { return }
//            DispatchQueue.main.async {
//                self.averageSpeed = quantity.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//    
//    private func fetchCalories(for sampleType: HKSampleType, startTime: Date, endTime: Date) {
//        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: .strictEndDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
//            guard let statistics = statistics, let quantity = statistics.sumQuantity() else { return }
//            DispatchQueue.main.async {
//                self.calories = quantity.doubleValue(for: HKUnit.kilocalorie())
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//    
//    private func fetchDistance(for sampleType: HKSampleType, startTime: Date, endTime: Date) {
//        let predicate = HKQuery.predicateForSamples(withStart: startTime, end: endTime, options: .strictEndDate)
//        
//        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
//            guard let statistics = statistics, let quantity = statistics.sumQuantity() else { return }
//            DispatchQueue.main.async {
//                self.distance = quantity.doubleValue(for: HKUnit.meter()) / 1000 // Convert meters to kilometers
//            }
//        }
//        
//        healthStore.execute(query)
//    }
//}

class HealthManager: ObservableObject {
    
    var healthStore: HKHealthStore?

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard let healthStore = self.healthStore else {
            completion(false)
            return
        }

        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!

        healthStore.requestAuthorization(toShare: [], read: [distanceType]) { (success, error) in
            completion(success)
        }
    }
}


class WorkoutManager: NSObject, ObservableObject {
    
    private var healthStore: HKHealthStore?
    private var query: HKAnchoredObjectQuery?

    @Published var distance: Double = 0.0

    override init() {
        super.init()
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }

    func requestAuthorization() {
        guard let healthStore = healthStore else { return }

        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!

        healthStore.requestAuthorization(toShare: nil, read: [distanceType]) { success, error in
            if success {
                print("Permissão concedida para acessar dados de distância")
            } else {
                print("Permissão negada para acessar dados de distância")
            }
        }
    }

    func startWorkout() {
        guard let healthStore = healthStore else { return }

        let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let predicate = HKQuery.predicateForSamples(withStart: Date(), end: nil, options: .strictStartDate)

        query = HKAnchoredObjectQuery(
            type: distanceType,
            predicate: predicate,
            anchor: nil,
            limit: HKObjectQueryNoLimit
        ) { [weak self] query, samples, deletedObjects, newAnchor, error in
            self?.process(samples: samples)
        }

        query?.updateHandler = { [weak self] query, samples, deletedObjects, newAnchor, error in
            self?.process(samples: samples)
        }

        healthStore.execute(query!)
    }
    
    func stopWorkout() {
          guard let healthStore = healthStore, let query = query else { return }
          healthStore.stop(query)
          self.query = nil
          print("Exercício encerrado")
      }
    

    private func process(samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else { return }

        for sample in samples {
            let distanceUnit = HKUnit.meter()
            let distance = sample.quantity.doubleValue(for: distanceUnit)
            let distanceInKilometers = distance / 1000

            DispatchQueue.main.async {
                self.distance += distanceInKilometers
            }
        }
    }
}
