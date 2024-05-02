//
//  BotaoDia.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct BotaoDia: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.oceanBlue)
            .cornerRadius(15)
    }
}

