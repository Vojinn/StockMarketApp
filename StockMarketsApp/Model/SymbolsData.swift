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
        id = ""
        name = ""
        tickerSymbol = ""
        isin = ""
        currency = ""
        stockExchangeName = ""
        decorativeName = ""
        quote = QuoteData()
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
        last = 0
        high = 0
        low = 0
        bid = 0
        ask = 0
        volume = 0
        dateTime = ""
        change = 0
        changePercent = 0
    }
}

struct NewsData {
    var id: String
    var author: String
    var dateTime: String
    var sourceName: String
    var headLine: HeadLine
    var picTT: PicTT
    init() {
        id = ""
        author = ""
        dateTime = ""
        sourceName = ""
        headLine = HeadLine()
        picTT = PicTT()
    }
}

struct HeadLine {
    var textHeadline: String
    init() {
        textHeadline = ""
    }
}

struct PicTT {
    var imageId: Int
    init() {
        imageId = 0
    }
}

struct NewsModel {
    var headline: String
    var image: UIImage
    init() {
        headline = ""
        image = UIImage()
    }
}

