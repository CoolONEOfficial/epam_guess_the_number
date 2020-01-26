//
//  ViewController.swift
//  epam_firstApp
//
//  Created by Nickolay Truhin on 26.01.2020.
//  Copyright © 2020 Nickolay Truhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.contentMode = .scaleToFill
        titleLabel.numberOfLines = 0
        attemptButton.setTitle(
            "Attempt \(attemptsCount + 1)",
            for: .normal
        )
    }

    @IBAction func onAttemptClicked(_ sender: Any) {
        let inputNumber = Int(numberTextField.text!)!
        
        var labelStr: String
        if inputNumber > randomNumber {
            labelStr = "Too much"
            attemptsCount += 1
        } else if inputNumber < randomNumber {
            labelStr = "Too small"
            attemptsCount += 1
        } else {
            labelStr = "You win using \(attemptsCount) \(attemptsCount > 1 ? "attempts" : "attempt"). Random number regenerated."
            randomNumber = UInt8.random(in: 0...99)
            attemptsCount = 0
        }
        
        titleLabel.text = labelStr
        attemptButton.setTitle(
            "Attempt \(attemptsCount + 1)",
            for: .normal
        )
    }
    
    var randomNumber: UInt8 = UInt8.random(in: 0...99)
    var attemptsCount: UInt = 0
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var attemptButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
}

