//
//  AuthenticationViewController.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    
    // Outlets to access views and contraints to animate
    @IBOutlet weak var backButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    
    @IBOutlet weak var topLabelConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        firstField.delegate = self
        secondField.delegate = self
        thirdField.delegate = self
        fourthField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // We get the string that would result of accepting the change of characters
        let currentString = textField.text ?? ""
        guard let changeRange = Range(range, in: string) else {
            return false
        }
        
        let resultingString = currentString.replacingCharacters(in: changeRange, with: string)
        
        // Then we check the length
        let resultingLength = resultingString.count
        
        if resultingLength <= 1 {
            // And finally check that the user is only entering numeric characters
            let numericSet = CharacterSet.decimalDigits
            let stringSet = CharacterSet(charactersIn: string)
            let onlyNumeric = numericSet.isSuperset(of: stringSet)
            
            if onlyNumeric {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        doAuthentication()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func doAuthentication() {
        var validCode: Bool
        if let firstCode = firstField.text, let secondCode = secondField.text, let thirdCode = thirdField.text, let fourthCode = fourthField.text {
            let fullCode = firstCode + secondCode + thirdCode + fourthCode
            validCode = Services.validate(code: fullCode)
        } else {
            validCode = false
        }
        
        if validCode {
            // BEGIN-UOC-2
            UIView.animate(withDuration: 0.5, animations: {
                self.firstField.alpha = 0
                self.secondField.alpha = 0
                self.thirdField.alpha = 0
                self.fourthField.alpha = 0
                
                self.firstLabel.alpha = 0
                self.secondLabel.alpha = 0
                self.thirdLabel.alpha = 0
                self.fourthLabel.alpha = 0
                
                self.view.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: 1, animations: {
                    self.topLabelConstraint.constant = -(self.topLabelConstraint.constant + self.topLabel.frame.height)
                    self.backButtonConstraint.constant = self.view.layoutMargins.left + self.backButton.frame.width
                    self.nextButtonConstraint.constant = -(self.view.layoutMargins.right + self.nextButton.frame.width)
                    
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    self.topLabel.alpha = 0
                    self.nextButton.alpha = 0
                    self.backButton.alpha = 0
                    
                    self.performSegue (withIdentifier: "SegueToMainNavigation", sender: self)
                })
            }
            // END-UOC-2
        } else {
            let errorMessage = "Sorry, the entered code is not valid"
            let errorTitle = "We could not autenticate you"
            Utils.show (Message: errorMessage, WithTitle: errorTitle, InViewController: self)
        }
    }
    
    // BEGIN-UOC-1
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstField.becomeFirstResponder()
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        switch sender {
        case firstField:
            secondField.becomeFirstResponder()
        case secondField:
            thirdField.becomeFirstResponder()
        case thirdField:
            fourthField.becomeFirstResponder()
        default:
            doAuthentication()
        }
    }
    // END-UOC-1
}
