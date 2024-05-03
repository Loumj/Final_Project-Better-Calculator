//
//  LogViewController.swift
//  BetterCalculator
//
//  Created by  on 5/3/24.
//

import UIKit

class LogViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var logs: [String] = []

      override func viewDidLoad() {
          super.viewDidLoad()
          tableView.dataSource = self
          
          // Fetch the initial logs and setup the update handler
          updateLogs()
          Logger.shared.logUpdateHandler = { [weak self] in
              self?.updateLogs()
          }
      }

      private func updateLogs() {
          logs = Logger.shared.logs  // Update the local logs array
          DispatchQueue.main.async {
              self.tableView.reloadData()  // Refresh the tableView on the main thread
          }
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return logs.count
      }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LogCell", for: indexPath)
        
        let fullLogEntry = logs[indexPath.row]
        let logMessage = fullLogEntry.components(separatedBy: ": ").dropFirst().joined(separator: ": ")
        
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)  
        
        cell.textLabel?.text = logMessage
        return cell
    }
      
  }
