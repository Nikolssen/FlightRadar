//
//  TicketCell.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/11/21.
//

import UIKit

class TicketCell: UITableViewCell {

    @IBOutlet var priceLabel: MonochromeLabel!
    @IBOutlet var dateLabel: MonochromeLabel!
    @IBOutlet var companyLabel: MonochromeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceLabel.attributes = TextAttributes.smallRegularAttributes
        companyLabel.attributes = TextAttributes.averageMediumAttributes
        dateLabel.attributes = TextAttributes.averageRegularAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        priceLabel.text = nil
        dateLabel.text = nil
        companyLabel.text = nil
    }
    
    func configure(with viewModel: TicketCellViewModelling) {
        priceLabel.text = viewModel.price
        companyLabel.text = viewModel.company
        
    }
}
