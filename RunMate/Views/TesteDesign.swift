//
//  TesteDesign.swift
//  RunMate
//
//  Created by Roberta Cordeiro on 07/05/24.
//

import SwiftUI

struct TesteDesign: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.darkPurple, .lilacPurple, .lakeBlue, .turquoiseGreen]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 25)
                .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    TesteDesign()
}
