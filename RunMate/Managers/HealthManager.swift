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

#Preview {
    HealthViewTeste()
}

struct HealthViewTeste: View {
    private var healthStore = HKHealthStore()
    
    @State private var averageSpeed: Double = 0.0
    @State private var calories: Double = 0.0
    @State private var distance: Double = 0.0
    
    var body: some View {
        VStack {
            Text("Velocidade Média: \(averageSpeed, specifier: "%.2f") km/h")
            Text("Calorias: \(calories, specifier: "%.2f") kcal")
            Text("Distância: \(distance, specifier: "%.2f") km")
                .onAppear(perform: requestAuthorization)
        }
        .padding()
    }
    
    private func requestAuthorization() {
        let typesToRead: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKObjectType.quantityType(forIdentifier: .walkingSpeed)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: typesToRead) { (success, error) in
            if success {
                fetchHealthData()
            } else {
                print("Authorization failed.")
            }
        }
    }
    
    private func fetchHealthData() {
        let speedType = HKSampleType.quantityType(forIdentifier: .walkingSpeed)!
        let caloriesType = HKSampleType.quantityType(forIdentifier: .activeEnergyBurned)!
        let distanceType = HKSampleType.quantityType(forIdentifier: .distanceWalkingRunning)!
        
        fetchAverageSpeed(for: speedType)
        fetchCalories(for: caloriesType)
        fetchDistance(for: distanceType)
    }
    
    private func fetchAverageSpeed(for sampleType: HKSampleType) {
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .discreteAverage) { (query, statistics, error) in
            guard let statistics = statistics, let quantity = statistics.averageQuantity() else { return }
            DispatchQueue.main.async {
                self.averageSpeed = quantity.doubleValue(for: HKUnit.meter().unitDivided(by: HKUnit.second()))
            }
        }
        
        healthStore.execute(query)
    }
    
    private func fetchCalories(for sampleType: HKSampleType) {
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
            guard let statistics = statistics, let quantity = statistics.sumQuantity() else { return }
            DispatchQueue.main.async {
                self.calories = quantity.doubleValue(for: HKUnit.kilocalorie())
            }
        }
        
        healthStore.execute(query)
    }
    
    private func fetchDistance(for sampleType: HKSampleType) {
        let predicate = HKQuery.predicateForSamples(withStart: Calendar.current.startOfDay(for: Date()), end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: sampleType as! HKQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, statistics, error) in
            guard let statistics = statistics, let quantity = statistics.sumQuantity() else { return }
            DispatchQueue.main.async {
                self.distance = quantity.doubleValue(for: HKUnit.meter()) / 1000 // Convert meters to kilometers
            }
        }
        
        healthStore.execute(query)
    }
}