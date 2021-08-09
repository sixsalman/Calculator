//
//  HistoryViewController.swift
//  Calculator
//
//  Created by Salman on 8/9/21.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var pastCalcs: [String]!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastCalcs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = pastCalcs[indexPath.row]
        
        return cell
    }
    
}
