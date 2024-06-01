import Foundation
import CoreLocation

@Observable class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var distance: Double = 0.0
    var acceleration: Double = 0.0
    private var lastLocation: CLLocation?
    private var lastSpeed: Double = 0.0
    private var lastTimestamp: Date? = Date()
    var isRunning: Bool = false
    private var todasLocations: [CLLocation] = []
    private let minDistanceChange: CLLocationDistance = 10 // Filtrar mudanças menores que 10 metros
    private let minHorizontalAccuracy: CLLocationAccuracy = 50 // Aceitar apenas localizações com precisão horizontal melhor que 20 metros
    private let maxDistanceChange: CLLocationDistance = 30
    var isPaused: Bool = false
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if self.locationManager.authorizationStatus == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        self.lastLocation = locationManager.location
        self.locationManager.startUpdatingLocation()
        // handling the background
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.showsBackgroundLocationIndicator = true
    }
    
    func stopCollectingLocations() {
        self.locationManager.stopUpdatingLocation()
    }
    
    func resumeCollectingLocations() {
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isRunning {
            guard let newLocation = locations.last else { return }
            // Filtrar localizações com baixa precisão
//            if newLocation.horizontalAccuracy > minHorizontalAccuracy || newLocation.horizontalAccuracy < 0 {
//                return
//            }
            
            // Verificar distância mínima
            if let lastLocation = lastLocation {
                let distanceDelta = newLocation.distance(from: lastLocation)
                
                // Calcular o tempo decorrido
                let timeDelta = newLocation.timestamp.timeIntervalSince(lastLocation.timestamp)
                
                // Calcular a velocidade atual
                let currentSpeed = distanceDelta / timeDelta
                
                // Calcular a aceleração
                if let lastTimestamp = lastTimestamp {
                    if currentSpeed > 0.27 && currentSpeed < 5 { // valores para caminhada == 1km/h e corrida muito forte == 18 km/h
                        let speedDelta = currentSpeed - lastSpeed
                        let timeSinceLastUpdate = newLocation.timestamp.timeIntervalSince(lastTimestamp)
                        if timeSinceLastUpdate > 0 {
                            let currentAcceleration = speedDelta / timeSinceLastUpdate // Calcula a aceleração
                            if currentAcceleration < 5 && currentAcceleration > 0.28 { // Assumindo um timestemp de 1s para a equação V = Vo + at
                                DispatchQueue.main.async {
                                    self.distance += distanceDelta / 1000
                                    self.acceleration = currentAcceleration
                                    self.lastLocation = newLocation
                                    // Atualizar as variáveis para a próxima leitura
                                    self.lastSpeed = currentSpeed
                                    self.lastTimestamp = newLocation.timestamp
                                    print("PASSOU:", currentAcceleration)
                                }
                            } else {
                                print("Aceleração fora das medidas:", currentAcceleration)
                            }
                        }
                    } else {
                        print("Velocidade inválida: ", currentSpeed)
                    }
                }
                return
            }
        }
    }
}



//import CoreLocation
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    var locationManager = CLLocationManager()
//    @Published var distance: Double = 0.0
//    private var lastLocation: CLLocation?
//    var isRunning: Bool = false
//    private var todasLocations: [CLLocation] = []
//    private let minDistanceChange: CLLocationDistance = 10 // Filtrar mudanças menores que 10 metros
//    private let minHorizontalAccuracy: CLLocationAccuracy = 50 // Aceitar apenas localizações com precisão horizontal melhor que 20 metros
//    private let maxDistanceChange: CLLocationDistance = 30
//    
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        if self.locationManager.authorizationStatus == .notDetermined {
//            self.locationManager.requestWhenInUseAuthorization()
//        }
//        self.lastLocation = locationManager.location
//        self.locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if isRunning {
//            guard let newLocation = locations.last else { return }
//            // Filtrar localizações com baixa precisão
//            if newLocation.horizontalAccuracy > minHorizontalAccuracy || newLocation.horizontalAccuracy < 0 {
//                return
//            }
//            
//            // Verificar distância mínima
//            if let lastLocation = lastLocation {
//                let distanceDelta = newLocation.distance(from: lastLocation)
//                if distanceDelta < minDistanceChange || distanceDelta > maxDistanceChange {
//                    return
//                }
//                distance += (distanceDelta/1000)
//                self.lastLocation = newLocation
//                return
//            }
//        }
//    }
//}
