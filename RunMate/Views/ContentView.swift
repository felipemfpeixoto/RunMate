import SwiftUI

enum Nivel {
    case iniciante, intermediario, avancado
}

enum Objetivo {
    case menor, medio, maior
}

var escolhas: MeuPlano? = nil

struct ContentView: View {
    var body: some View {
        NavigationStack {
            EscolhaNivelView()
        }
    }
}

#Preview {
    ContentView()
}
