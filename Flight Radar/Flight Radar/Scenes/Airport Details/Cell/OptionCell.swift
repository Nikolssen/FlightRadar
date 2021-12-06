//
//  OptionCell.swift
//  Flight Radar
//
//  Created by Ivan Budovich on 12/6/21.
//

import SwiftUI

struct OptionCell: View {
    let viewModel: OptionCellViewModel
    let isSelected: Bool
    var body: some View {
        Text(viewModel.text)
            .font(.oswaldMedium(size: 18))
            .foregroundColor(isSelected ? .manhattan : .sanMarino)
    }
}

struct OptionCell_Previews: PreviewProvider {
    static var previews: some View {
        OptionCell(viewModel: .init(text: "Map", index: 0), isSelected: true)
    }
}
