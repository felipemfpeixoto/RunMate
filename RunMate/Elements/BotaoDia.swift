//
//  BotaoDia.swift
//  RunMate
//
//  Created by infra on 02/05/24.
//

import SwiftUI

struct AnyButtonStyle: ButtonStyle {
    private let _makeBody: (Configuration) -> AnyView

    init<Style: ButtonStyle>(_ style: Style) {
        _makeBody = { configuration in AnyView(style.makeBody(configuration: configuration)) }
    }

    func makeBody(configuration: Configuration) -> some View {
        _makeBody(configuration)
    }
}

struct BotaoDia: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.oceanBlue)
            .cornerRadius(15)
    }
}

struct BotaoDiaTurquesa: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.turquoiseGreen)
            .cornerRadius(15)
    }
}

struct BotaoDiaLilas: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.lilacPurple)
            .cornerRadius(15)
    }
}

struct BotaoDiaDarkPurple: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.darkPurple)
            .cornerRadius(15)
    }
}

struct BotaoDiaLightBlue: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.ourLightBlue)
            .cornerRadius(15)
    }
}

struct BotaoDiaLakeBlue: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 72.22, height: 87.7, alignment: .center)
            .background(Color.lakeBlue)
            .cornerRadius(15)
    }
}
