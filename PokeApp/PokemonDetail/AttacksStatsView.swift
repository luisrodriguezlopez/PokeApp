//
//  AttacksStatsView.swift
//  PokeApp
//
//  Created by Luis Rodríguez López on 29/09/25.
//

import SwiftUI


public struct AttacksStatsView: View {
    var attacks: [Attack]
    let screenWidth = UIScreen.main.bounds.width

    public var body: some View {
        ForEach(Array(attacks), id: \.damage ) { attack in
            HStack(alignment: .center, spacing: 16, content: {
                Spacer()
                Text(attack.name)
                    .frame(width: screenWidth * 0.4, height: 10)
                    .padding(.leading, 16)
                Text("\(attack.damage)")
                    .frame(width: screenWidth * 0.1, height: 10)
                ProgressView(value: Double(attack.damage), total: 100)
                    .frame(width: screenWidth * 0.5, height: 10)
                    .padding(.trailing, 16)
            })
            .padding()
        }
    }
}
