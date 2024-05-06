import Foundation
import CodableExtensions

let dao = DAO.instance

@Observable class DAO: Codable {
    static var instance = (try? DAO.load()) ?? DAO()
    
    var paginaDeTreinamento: PaginaDeTreinamento = PaginaDeTreinamento(planoDeTreinamento: PlanoDeTreinamento(semanas: []))
    
    var idade: Int? = nil
    
    var semanaAtual: Int = -1
    
    var diaAtual: Int = -1
    
    var diasConcluidos: [Int] = []
    
    private init() {
//        loadTreino()
    }
    
    func loadJsonFileFromObjective() {
        let filename = (escolhas?.nivel ?? "") + (escolhas?.objetivo ?? "") + ".json"
        let data: PaginaDeTreinamento = Bundle.main.decode(file: filename)
        
        self.paginaDeTreinamento = data
        self.semanaAtual = 0
        self.diaAtual = 0
        self.diasConcluidos = []
//        savePaginaDeTerinamento()
//        loadTreino()
        
        let plano: PlanoDeTreinamento = data.planoDeTreinamento
        let semanas = plano.semanas
        return semanas

//        do {
            
//            let docsArray = try fileManager.contentsOfDirectory(atPath: docsPath)
//            for item in docsArray {
//                if item == filename {
//                    print(item)
//                }
//                guard let semana =  try? Semana.load(from: item) else {continue}
//                planejamento.append(semana)
//            }
//        } catch {
//            print(error)
//        }
    }
    
    func loadTreino() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentDirectory.appendingPathComponent("treino.json")
        
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let treinamento = try JSONDecoder().decode(PaginaDeTreinamento.self, from: data)
                self.paginaDeTreinamento = treinamento
            } catch {
                print("Error loading treinamento: \(error.localizedDescription)")
            }
        } else {
            do {
                let data = try JSONEncoder().encode(self.paginaDeTreinamento)
                try data.write(to: fileURL)
            } catch {
                print("Error creating new treino: \(error.localizedDescription)")
            }
        }
    }
    
    func savePaginaDeTerinamento() {
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentDirectory.appendingPathComponent("treino.json")
        print(fileURL)
        do {
            let data = try JSONEncoder().encode(self.paginaDeTreinamento)
            try data.write(to: fileURL)
        } catch {
            print("Error saving treinamento: \(error.localizedDescription)")
        }
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
