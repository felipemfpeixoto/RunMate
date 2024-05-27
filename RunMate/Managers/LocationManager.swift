
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    @Published var distance: Double = 0.0
    private var lastLocation: CLLocation?
    var isRunning: Bool = false
    private var todasLocations: [CLLocation] = []
    private let minDistanceChange: CLLocationDistance = 10 // Filtrar mudanças menores que 10 metros
    private let minHorizontalAccuracy: CLLocationAccuracy = 40 // Aceitar apenas localizações com precisão horizontal melhor que 20 metros
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if self.locationManager.authorizationStatus == .notDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
        self.lastLocation = locationManager.location
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isRunning {
            guard let newLocation = locations.last else { return }
            // Filtrar localizações com baixa precisão
            if newLocation.horizontalAccuracy > minHorizontalAccuracy || newLocation.horizontalAccuracy < 0 {
                print("Abaixo do mínimo: ", newLocation.horizontalAccuracy)
                return
            }
            print("Passou: ", newLocation.horizontalAccuracy)
            
            // Verificar distância mínima
            if let lastLocation = lastLocation {
                let distanceDelta = newLocation.distance(from: lastLocation)
                if distanceDelta < minDistanceChange {
                    print("Abaixo do mínimo de distancia: ", distanceDelta)
                    return
                }
                print("Acima do mínimo de distancia: ", distanceDelta)
                distance += (distanceDelta/1000)
                self.lastLocation = newLocation
            }
        }
    }
}
