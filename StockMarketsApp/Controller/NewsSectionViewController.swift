//
//  NewsSectionViewController.swift
//  StockMarketsApp
//
//  Created by Dusan Vojinovic on 2.2.22..
//

import UIKit

class NewsSectionViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    var results = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension NewsSectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.configure(with: results[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
