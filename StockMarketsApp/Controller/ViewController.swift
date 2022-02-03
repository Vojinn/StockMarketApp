//
//  ViewController.swift
//  StockMarketsApp
//
//  Created by Dusan Vojinovic on 31.1.22..
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var nameSymbol: UILabel!
    enum nameState {
        case random
        case asc
        case desc
    }
    var nameOrder = nameState.random
    let symbolURL = "https://www.teletrader.rs/downloads/tt_symbol_list.xml"
    let newsURL = "https://www.teletrader.rs/downloads/tt_news_list.xml"
    
    var results = [SymbolsData]()
    var randomOrder = [SymbolsData]()
    var symbol = SymbolsData()
    
    
    var news = NewsData()
    var newsResults = [NewsData]()
    var newsModelDataResults = [NewsModel]()
    
    var user: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "basicAccessAuthentication-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'basicAccessAuthentication-Info'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "USERNAME") as? String else {
                fatalError("Couldn't find key 'USERNAME' in 'basicAccessAuthentication-Info'")
            }
            return value
        }
    }
    var password: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "basicAccessAuthentication-Info", ofType: "plist") else {
                fatalError("Couldn't find file 'basicAccessAuthentication-Info'")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "PASSWORD") as? String else {
                fatalError("Couldn't find key 'PASSWORD' in 'basicAccessAuthentication-Info'")
            }
            return value
        }
    }
    var foundCharacters = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        urlReading(urlForReading: symbolURL)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.urlReading(urlForReading: self.newsURL)
        }
        
        tableView.register(SymbolTableViewCell.nib(), forCellReuseIdentifier: SymbolTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        // za kliktanje Name labela da se promeni redosled
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        nameSymbol.addGestureRecognizer(tap)
    }
    
    @IBAction func newsPressed(_ sender: UITabBarItem) {
        self.performSegue(withIdentifier: "goToNews", sender: self)
    }
    
    func urlReading(urlForReading: String) {
        let config = URLSessionConfiguration.default
        let userPasswordData = "\(user):\(password)".data(using: .utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        let session = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue())

        let url = URL(string: urlForReading)
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                let parser = XMLParser(data: data!)
                parser.delegate = self
                parser.parse()
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetails" {
            let destinationVC = segue.destination as! SymbolDetailsViewController
            destinationVC.name = symbol.name
            destinationVC.last = symbol.quote.last
            destinationVC.high = symbol.quote.high
            destinationVC.low = symbol.quote.low
            destinationVC.bid = symbol.quote.bid
            destinationVC.ask = symbol.quote.ask
            destinationVC.volume = symbol.quote.volume
            destinationVC.change = symbol.quote.change
            destinationVC.changePercent = symbol.quote.changePercent
        }
        if segue.identifier == "goToNews" {
            let destinationVC = segue.destination as! NewsSectionViewController
            destinationVC.results = newsModelDataResults
        }
    }
    
    @objc
    func tapFunction(sender: UITapGestureRecognizer){
        switch nameOrder {
        case .random:
            results = results.sorted(by: { $0.name < $1.name })
            tableView.reloadData()
            nameOrder = .asc
        case .asc:
            results = results.sorted(by: { $0.name > $1.name })
            tableView.reloadData()
            nameOrder = .desc
        case .desc:
            results = randomOrder
            tableView.reloadData()
            nameOrder = .random
        }
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let proposedCredential = URLCredential(user: user, password: password, persistence: .none)
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.useCredential, proposedCredential)
    }
}

extension ViewController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Quote" {
            var tempQuote = QuoteData()
            if let l = attributeDict["last"] {
                if let last = Double(l){
                    tempQuote.last = last
                }
            }
            if let l = attributeDict["high"] {
                if let high = Double(l){
                    tempQuote.high = high
                }
            }
            if let l = attributeDict["low"] {
                if let low = Double(l){
                    tempQuote.low = low
                }
            }
            if let l = attributeDict["bid"] {
                if let bid = Double(l){
                    tempQuote.bid = bid
                }
            }
            if let l = attributeDict["ask"] {
                if let ask = Double(l){
                    tempQuote.ask = ask
                }
            }
            if let l = attributeDict["volume"] {
                if let volume = Double(l){
                    tempQuote.volume = volume
                }
            }
            if let dateTime = attributeDict["dateTime"] {
                tempQuote.dateTime = dateTime
            }
            if let l = attributeDict["change"] {
                if let change = Double(l){
                    tempQuote.change = change
                }
            }
            if let l = attributeDict["changePercent"] {
                if let changePercent = Double(l){
                    tempQuote.changePercent = changePercent
                }
            }
            symbol.quote = tempQuote
        }
        if elementName == "Symbol" {
            if let id = attributeDict["id"] {
                symbol.id = id
            }
            if let name = attributeDict["name"] {
                symbol.name = name
            }
            if let tickerSymbol = attributeDict["tickerSymbol"] {
                symbol.tickerSymbol = tickerSymbol
            }
            if let isin = attributeDict["isin"] {
                symbol.isin = isin
            }
            if let currency = attributeDict["currency"] {
                symbol.currency = currency
            }
            if let stockExchangeName = attributeDict["stockExchangeName"] {
                symbol.stockExchangeName = stockExchangeName
            }
            if let decorativeName = attributeDict["decorativeName"] {
                symbol.decorativeName = decorativeName
            }
        }
        if elementName == "NewsArticle" {
            self.news = NewsData()
            if let id = attributeDict["id"]{
                news.id = id
            }
            if let author = attributeDict["author"] {
                news.author = author
            }
            if let dateTime = attributeDict["dateTime"] {
                news.dateTime = dateTime
            }
            if let sourceName = attributeDict["sourceName"] {
                news.sourceName = sourceName
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if let someString = String(data: CDATABlock, encoding: .utf8) {
            news.headLine.textHeadline = someString
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.foundCharacters += string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Symbol" {
            results.append(symbol)
        }
        if elementName == "ImageID" {
            news.picTT.imageId = Int(foundCharacters.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines))!
        }
        if elementName == "NewsArticle" {
            newsResults.append(news)
        }
        
        self.foundCharacters = ""
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        randomOrder = results
        for newsData in newsResults {
            var newsModelData = NewsModel()
            newsModelData.headline = newsData.headLine.textHeadline
            if let url = URL(string: "https://cdn.ttweb.net/News/images/\(newsData.picTT.imageId).jpg?preset=w220_q40") {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }

                    DispatchQueue.main.async {
                        newsModelData.image = UIImage(data: data)!
                    }
                }
                task.resume()
            }
            newsModelDataResults.append(newsModelData)
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SymbolTableViewCell.identifier, for: indexPath) as! SymbolTableViewCell
        cell.configure(with: results[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32.0
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            results.remove(at: indexPath.row)
            randomOrder.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        symbol = results[indexPath.row]
        self.performSegue(withIdentifier: "goToDetails", sender: self)
    }
}


