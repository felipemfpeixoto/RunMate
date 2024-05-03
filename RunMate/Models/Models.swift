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

struct Semana: Codable, Hashable {
    let semana: Int
    let dias: [Dia]
}

struct PlanoDeTreinamento: Codable {
    let semanas: [Semana]
}

struct PaginaDeTreinamento: Codable {
    let planoDeTreinamento: PlanoDeTreinamento
}
