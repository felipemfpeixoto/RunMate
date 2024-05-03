import SwiftUI

struct ExercicioDetalhado: Codable {
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

struct Exercicio: Codable {
    let exercíciosDetalhados: [ExercicioDetalhado]
    let repeticoes: Int
}

struct Dia: Codable {
    let dia: String
    let exercicios: [Exercicio]
}

struct Semana: Codable {
    let semana: Int
    let dias: [Dia]
}

struct PlanoDeTreinamento: Codable {
    let semanas: [Semana]
}

struct PaginaDeTreinamento: Codable {
    let planoDeTreinamento: PlanoDeTreinamento
}
