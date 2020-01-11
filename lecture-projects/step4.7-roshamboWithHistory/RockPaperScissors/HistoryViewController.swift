//
//  HistoryViewController.swift
//  RockPaperScissors
//
//  Created by Jess Le on 1/10/20.
//  Copyright © 2020 Gabrielle Miller-Messner. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    public var history: [RPSMatch]?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissHistory(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let historyData = history?[indexPath.row] else { return UITableViewCell() }
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "HistoryCell")
        cell.textLabel?.text = isWinner(data: historyData) ? "Winner" : "Loser"
        cell.detailTextLabel?.text = "\(historyData.p1.description) vs \(historyData.p2.description)"
        return cell
    }
}

extension HistoryViewController {
    func isWinner(data: RPSMatch) -> Bool {
        return data.winner == data.p1
    }
}
