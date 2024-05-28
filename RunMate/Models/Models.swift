import SwiftUI

struct ExercicioDetalhado: Codable, Hashable {
    let nome: String
    let descricao: String
    let tempo: Int?
    let distancia: Int?
}

struct MeuPlano {
    let nivel: String
    let objetivo: String
    let idade: Int
}

struct Exercicio: Codable, Hashable {
    let exercíciosDetalhados: [ExercicioDetalhado]
    let repeticoes: Int
}

struct Dia: Codable, Hashable {
    let dia: Int
    let exercicios: [Exercicio]
}

struct Semana: Codable, Hashable, Identifiable {
    var id:Int {semana}
    let semana: Int
    let dias: [Dia]
}

struct PlanoDeTreinamento: Codable {
    var semanas: [Semana]
}

struct PaginaDeTreinamento: Codable {
    var planoDeTreinamento: PlanoDeTreinamento
}

struct FCM: Codable {
    var caminhada: String
    var leve: String
    var moderada: String
    var forte: String
    var muitoForte: String 
}

struct DadosSemana: Codable {
    var velocidadeMédia: Double
    var calorias: Double
    var distância: Double
    var paceMedio: Double
}
