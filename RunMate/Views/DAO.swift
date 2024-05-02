//
//  DAO.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import Foundation
import CodableExtensions


let dao = DAO.instance
class DAO: Codable {
    static var instance = (try? DAO.load()) ?? DAO()
    
    var planejamento: [Semana] = []
    
    private init() {
        loadJsonFiles()
    }
    
    func loadJsonFiles() {
        let docsPath = Bundle.main.resourcePath! + "/Data"
        let fileManager = FileManager.default

        do {
            let docsArray = try fileManager.contentsOfDirectory(atPath: docsPath)
            for item in docsArray {
                guard let semana =  try? Semana.load(from: item) else {continue}
                planejamento.append(semana)
            }
        } catch {
            print(error)
        }
    }
}
