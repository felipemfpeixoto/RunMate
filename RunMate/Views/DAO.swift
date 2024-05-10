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
    
    
    private init() {
    }
    
    func loadJsonFileFromObjective() {
        let filename = (escolhas?.nivel ?? "") + (escolhas?.objetivo ?? "") + ".json"
        let data: PaginaDeTreinamento = Bundle.main.decode(file: filename)
        
        self.paginaDeTreinamento = data
        self.semanaAtual = 0
        self.diaAtual = 0
        self.diasConcluidos = []
        self.fcm = 220.0 - (dao.idade ?? 0)
        self.fcmDescricao = FCM(caminhada: "\(Int(dao.fcm*0.5)) BPM a \(Int(dao.fcm*0.65)) BPM", leve: "\(Int(dao.fcm*0.65)) BPM a \(Int(dao.fcm*0.75)) BPM", moderada: "\(Int(dao.fcm*0.75)) BPM a \(Int(dao.fcm*0.85)) BPM", forte: "\(Int(dao.fcm*0.85)) BPM a \(Int(dao.fcm*0.9)) BPM", muitoForte: "\(Int(dao.fcm*0.9)) BPM a \(Int(dao.fcm)) BPM")
        self.nivelDescricao = ""
    }
}

extension Bundle {
    func decode<T: Decodable>(file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Could not find \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError("Could not decode \(file) from bundle.")
        }
        
        return loadedData
    }
}
