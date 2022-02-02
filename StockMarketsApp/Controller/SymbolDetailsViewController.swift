//
//  SymbolDetailsViewController.swift
//  StockMarketsApp
//
//  Created by Dusan Vojinovic on 1.2.22..
//

import UIKit

class SymbolDetailsViewController: UIViewController {
    
    @IBOutlet var highLabel: UILabel!
    @IBOutlet var lowLabel: UILabel!
    @IBOutlet var bidLabel: UILabel!
    @IBOutlet var askLabel: UILabel!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var changeLabel: UILabel!
    @IBOutlet var changePercentLabel: UILabel!
    @IBOutlet var lastLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var dataBar: UINavigationItem!
    
    var name: String?
    var high: Double?
    var low: Double?
    var bid: Double?
    var ask: Double?
    var volume: Double?
    var change: Double?
    var changePercent: Double?
    var last: Double?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dataBar.title = name!
        highLabel.text = String(high!)
        lowLabel.text = String(low!)
        bidLabel.text = String(bid!)
        askLabel.text = String(ask!)
        volumeLabel.text = String(volume!)
        changeLabel.text = String(change!)
        changePercentLabel.text = String(changePercent!)
        lastLabel.text = String(last!)
        if change! > 0 {
            changeLabel.textColor = .green
        } else if change! < 0 {
            changeLabel.textColor = .red
        } else {
            changeLabel.textColor = .white
        }
        if changePercent! > 0 {
            changePercentLabel.textColor = .green
        } else if change! < 0 {
            changePercentLabel.textColor = .red
        } else {
            changePercentLabel.textColor = .white
        }
    }
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
