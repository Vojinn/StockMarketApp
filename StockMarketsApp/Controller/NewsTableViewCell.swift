//
//  NewsTableViewCell.swift
//  StockMarketsApp
//
//  Created by Dusan Vojinovic on 2.2.22..
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var headline1Label: UILabel!
    @IBOutlet var headline2Label: UILabel!
    @IBOutlet var newsImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static let identifier = "NewsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
    func configure(with model: NewsModel) {
        self.headline1Label.text = model.headline
        self.headline2Label.text = model.headline
        self.newsImage.image = model.image
    }
    
}
