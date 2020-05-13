//
//  MovementsListViewController.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class MovementsListViewController: UITableViewController {
    // BEGIN-UOC-3
    var movements: [Movement]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMovements()
    }
    
    func setupMovements() {
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        movements = Services.getMovements()
    }
    // END-UOC-3
    
    // BEGIN-UOC-5
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movements.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movementsCount = movements.count
        
        if indexPath.row < movementsCount {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as? MovementCell else {
                fatalError("MovementCell is not available")
            }
            
            let movement = movements[indexPath.row]
            
            let description = movement.movementDescription
            
            let amount = String.withFormatted(amount: movement.amount)
            
            var amountColor: UIColor
            if movement.amount >= 0 {
                amountColor = UIColor.black
            } else {
                amountColor = UIColor.red
            }

            let date = String.withFormatted(date: movement.date)
            
            var backgroundColor: UIColor
            if movement.rejected {
                backgroundColor = UIColor.orange.lighter()
            } else {
                backgroundColor = UIColor.white
            }
            
            cell.configure(Description: description, Date: date, Amount: amount, AmountColor: amountColor, BackgroundColor: backgroundColor)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LastMovementCell", for: indexPath)
            
            return cell
        }
    }
    // END-UOC-5
    
    // BEGIN-UOC-7
    @IBAction func filterChanged(_ sender: UISegmentedControl) {
        let allMovements = Services.getMovements()
        
        switch sender.selectedSegmentIndex {
        case 0:
            movements = allMovements
        case 1:
            let filteredMovements = allMovements.filter {
                $0.category == "Transfers"
            }
            movements = filteredMovements
        case 2:
            let filteredMovements = allMovements.filter {
                $0.category == "Credit cards"
            }
            movements = filteredMovements
        case 3:
            let filteredMovements = allMovements.filter {
                $0.category == "Direct debits"
            }
            movements = filteredMovements
        default:
            fatalError("Unknown movement filter selected")
        }
        
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    // END-UOC-7
    
    // BEGIN-UOC-8.1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueToMovementDetail" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let movement = movements[row]
                
                if let destinationViewController = segue.destination as? MovementDetailViewController {
                    destinationViewController.movement = movement
                }
            }
        }
    }
    // END-UOC-8.1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
