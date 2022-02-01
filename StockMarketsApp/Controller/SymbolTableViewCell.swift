//
//  SymbolTableViewCell.swift
//  StockMarketsApp
//
//  Created by Dusan Vojinovic on 1.2.22..
//

import UIKit

class SymbolTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var percentLabel: UILabel!
    @IBOutlet var lastLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    static let identifier = "SymbolTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SymbolTableViewCell", bundle: nil)
    }
    
    func configure(with model: SymbolsData) {
        self.nameLabel.text = model.name
        var temp: String
        if model.quote.changePercent == 0 {
            temp = "0.00%"
        } else if model.quote.changePercent < 0 {
            percentLabel.textColor = .red
            temp = String(format: "%.2f", model.quote.changePercent) + "%"
        } else if model.quote.changePercent > 0{
            percentLabel.textColor = .green
            temp = "+" + String(format: "%.2f", model.quote.changePercent) + "%"
        } else {
            temp = "-"
        }
        self.percentLabel.text = temp
        self.lastLabel.text = String(format: "%.2f", model.quote.last)
    }
    
}
