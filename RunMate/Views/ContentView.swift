import SwiftUI

enum Nivel {
    case iniciante, intermediario, avancado
}

enum Objetivo {
    case menor, medio, maior
}

var nivelSelecionado: Nivel? = nil
var objetivoSelecionado: Objetivo? = nil

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
