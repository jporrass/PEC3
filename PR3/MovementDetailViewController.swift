//
//  MovementDetailViewController.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController {
    // BEGIN-UOC-8.2
    var movement: Movement!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountLabel.text = String.withFormatted(amount: movement.amount)
        
        if movement.amount >= 0 {
            amountLabel.textColor = UIColor.black
        } else {
            amountLabel.textColor = UIColor.red
        }
        
        balanceLabel.text = String.withFormatted(amount: movement.balance)        
        dateLabel.text = String.withFormatted(date: movement.date)
        valueDateLabel.text = String.withFormatted(date: movement.valueDate)
        
        descriptionLabel.text = movement.movementDescription
        
        setupRejection()
    }
    
    func setupRejection() {
        if movement.rejected {
            let label = UILabel()
            
            label.text = "Rejected"
            label.textColor = UIColor.red
            label.textAlignment = .center
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(label)
            
            let topConstraint = label.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10)
            let leadingConstraint = label.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            let trailingConstraint = label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            topConstraint.isActive = true
            leadingConstraint.isActive = true
            trailingConstraint.isActive = true
        } else {
            let button = UIButton(type: .system)
            
            button.setTitle("Reject", for: .normal)
            button.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(button)
            
            let topConstraint = button.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 10)
            let leadingConstraint = button.leadingAnchor.constraint(equalTo: view.leadingAnchor)
            let trailingConstraint = button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
            topConstraint.isActive = true
            leadingConstraint.isActive = true
            trailingConstraint.isActive = true
        }
    }
    // END-UOC-8.2
    
    // BEGIN-UOC-9
    @objc func rejectAction(sender: UIButton!) {
        movement.rejected = true
        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    // END-UOC-9
}
