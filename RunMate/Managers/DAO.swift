import Foundation
import CodableExtensions

let dao = DAO.instance

@Observable class DAO: Codable {
    static var instance = (try? DAO.load()) ?? DAO()
    
    var paginaDeTreinamento: PaginaDeTreinamento = PaginaDeTreinamento(planoDeTreinamento: PlanoDeTreinamento(semanas: []))
    
    var idade: Double? = nil
    
    var semanaAtual: Int = -1
    
    var diaAtual: Int = -1
    
    var diasConcluidos: [Int] = []
    
    var nivelSelecionado: String = ""
    
    var metaSelecionlada: String = ""
    
    var fcm: Double = -1
    
    var fcmDescricao: FCM = FCM(caminhada: "", leve: "", moderada: "", forte: "", muitoForte: "")
    
    var nivelDescricao: String = ""
    
    var caloriasTotais: Double = 0
    
    var velocidadeTotal: Double = 0.0
    
    var distanciaTotal: Double = 0.0
    
    var paceMedio: Double = 0.0
    
    var dadosSemanas: [DadosSemana] = []
    
    private init() {}
    
    func loadJsonFileFromObjective() {
        let filename = (escolhas?.nivel ?? "") + (escolhas?.objetivo ?? "") + ".json"
        let data: PaginaDeTreinamento = try! Bundle.main.decode(file: filename) as PaginaDeTreinamento
        
        self.paginaDeTreinamento = data
        self.semanaAtual = 0
        self.diaAtual = 0
        self.diasConcluidos = []
        for _ in 0..<self.paginaDeTreinamento.planoDeTreinamento.semanas.count {
            self.dadosSemanas.append(DadosSemana(velocidadeMédia: 0, calorias: 0, distância: 0, paceMedio: 0))
        }
//        print(self.dadosSemanas.count)
        self.fcm = 220.0 - (dao.idade ?? 0)
        self.fcmDescricao = FCM(caminhada: "\(Int(dao.fcm*0.5)) BPM a \(Int(dao.fcm*0.65)) BPM", leve: "\(Int(dao.fcm*0.65)) BPM a \(Int(dao.fcm*0.75)) BPM", moderada: "\(Int(dao.fcm*0.75)) BPM a \(Int(dao.fcm*0.85)) BPM", forte: "\(Int(dao.fcm*0.85)) BPM a \(Int(dao.fcm*0.9)) BPM", muitoForte: "\(Int(dao.fcm*0.9)) BPM a \(Int(dao.fcm)) BPM")
        self.nivelDescricao = ""
        self .paceMedio = 0.0
        self.velocidadeTotal = 0.0
        self.distanciaTotal = 0.0
        self.caloriasTotais = 0.0
    }
}

enum BundleDecodingError: Error {
    case fileNotFound(String)
    case couldNotLoadData(String)
    case decodingFailure(String)
}


extension Bundle {
    func decode<T: Decodable>(file: String) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw BundleDecodingError.fileNotFound("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw BundleDecodingError.couldNotLoadData("Could not load \(file) from bundle.")
        }
        
        guard let loadedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw BundleDecodingError.decodingFailure("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}

