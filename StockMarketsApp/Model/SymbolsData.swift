//
//  XMLParser.swift
//  StockMarketsApp
//
//  Created by Dusan Vojinovic on 31.1.22..
//

import Foundation
import UIKit

struct SymbolsData {
    var id : String
    var name: String
    var tickerSymbol: String
    var isin: String
    var currency: String
    var stockExchangeName: String
    var decorativeName: String
    var quote: QuoteData
    init() {
        self.id = ""
        self.name = ""
        self.tickerSymbol = ""
        self.isin = ""
        self.currency = ""
        self.stockExchangeName = ""
        self.decorativeName = ""
        self.quote = QuoteData()
    }
}

struct QuoteData {
    var last: Double
    var high: Double
    var low: Double
    var bid: Double
    var ask: Double
    var volume: Double
    var dateTime: String
    var change: Double
    var changePercent: Double
    init() {
        self.last = 0
        self.high = 0
        self.low = 0
        self.bid = 0
        self.ask = 0
        self.volume = 0
        self.dateTime = ""
        self.change = 0
        self.changePercent = 0
    }
}

//class SymbolParser: NSObject {
//    var xmlParser: XMLParser?
//    var games: []
//}
