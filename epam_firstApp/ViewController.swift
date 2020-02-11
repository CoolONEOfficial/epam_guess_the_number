//
//  ViewController.swift
//  epam_firstApp
//
//  Created by Nickolay Truhin on 26.01.2020.
//  Copyright © 2020 Nickolay Truhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var attemptButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    
    var randomNumber: UInt?
    
    private var _attemptsCount: UInt = 0
    var attemptsCount: UInt {
        get {
            return _attemptsCount
        }
        
        set(newValue) {
            attemptButton.setTitle(
                String.localizedStringWithFormat(
                    NSLocalizedString("attemptButton", comment: ""),
                    newValue + 1
                ),
                for: .normal
            )
            _attemptsCount = newValue
        }
    }
    
    static let averageAttemptsKey = "averageAttempts"
    private var _averageAttempts: Float =
        UserDefaults.standard.float(forKey: ViewController.averageAttemptsKey)
    var averageAttempts: Float {
        get {
            return _averageAttempts
        }
        
        set(newValue) {
            _averageAttempts = newValue
            UserDefaults.standard.set(newValue, forKey: ViewController.averageAttemptsKey)
        }
    }
    
    static let totalAttemptsCountKey = "totalAttemptsCount"
    private var _totalAttemptsCount: UInt = UInt(
           UserDefaults.standard.integer(
               forKey: ViewController.totalAttemptsCountKey
           )
       )
    var totalAttemptsCount: UInt {
        get {
            return _totalAttemptsCount
        }
        
        set(newValue) {
            _totalAttemptsCount = newValue
            UserDefaults.standard.set(newValue, forKey: ViewController.totalAttemptsCountKey)
        }
    }
    
    static let gamesCountKey = "gamesCount"
    private var _gamesCount: UInt = UInt(
        UserDefaults.standard.integer(
            forKey: ViewController.gamesCountKey
        )
    )
    var gamesCount: UInt {
        get {
            return _gamesCount
        }
        
        set(newValue) {
            _gamesCount = newValue
            UserDefaults.standard.set(newValue, forKey: ViewController.gamesCountKey)
        }
    }
    
    static let randomMaxKey = "randMax"
    private var _randomMax: UInt?
    var randomMax: UInt? {
        get {
            return _randomMax
        }
        set(newValue) {
            _randomMax = newValue
            UserDefaults.standard.set(newValue, forKey: ViewController.randomMaxKey)
            onRangeChanged()
        }
    }
    
    static let randomMinKey = "randMin"
    private var _randomMin: UInt?
    var randomMin: UInt? {
        get {
            return _randomMin
        }
        set(newValue) {
            _randomMin = newValue
            UserDefaults.standard.set(newValue, forKey: ViewController.randomMinKey)
            onRangeChanged()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Wrap lines prefs
        titleLabel.contentMode = .scaleToFill
        titleLabel.numberOfLines = 0
        
        attemptButton.isEnabled = false
        let userDefs = UserDefaults.standard
        if let defRandomMax = userDefs.object(forKey: ViewController.randomMaxKey) as? Int,
            let defRandomMin = userDefs.object(forKey: ViewController.randomMinKey) as? Int {
            randomMax = UInt(defRandomMax)
            randomMin = UInt(defRandomMin)
        }
        attemptsCount = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "settingsSegue":
            if let controller = segue.destination as? SettingsViewController {
                controller.defaultRandomMax = randomMax
                controller.defaultRandomMin = randomMin
                controller.delegate = self
            }
        case "statisticsSegue":
            if let controller = segue.destination as? StatisticsViewController {
                controller.gamesCount = gamesCount
                controller.totalAttemptsCount = totalAttemptsCount
                controller.averageAttempts = averageAttempts
            }
        default: break
        }
    }

    @IBAction func onAttemptClicked(_ sender: Any) {
        if let validInputNumberStr = numberTextField.text,
            let validInputNumber = Int(validInputNumberStr),
            let validRandomNumber = randomNumber {
            var labelStr: String
            
            attemptsCount += 1
            totalAttemptsCount += 1
            
            if validInputNumber > validRandomNumber {
                labelStr = NSLocalizedString("tooMuch", comment: "")
            } else if validInputNumber < validRandomNumber {
                labelStr = NSLocalizedString("tooSmall", comment: "")
                
            } else {
                labelStr = String.localizedStringWithFormat(
                    NSLocalizedString("win", comment: ""),
                    attemptsCount
                )
                restartGame(gameComplete: true)
            }
            
            titleLabel.text = labelStr
        }
    }
    
    func onRangeChanged() {
        if let validRandomMin = randomMin,
            let validRandomMax = randomMax {
            titleLabel.text = String.localizedStringWithFormat(
                NSLocalizedString("enterNumber", comment: ""),
                validRandomMin,
                validRandomMax
            )
            numberTextField.placeholder = "\(validRandomMin)-\(validRandomMax)"
            attemptButton.isEnabled = true
            restartGame()
        } else {
            titleLabel.text = NSLocalizedString("setSettings", comment: "")
            attemptButton.isEnabled = false
        }
    }
    
    func onUpdateRandomMax(newValue: UInt) {
        randomMax = newValue
    }
    
    func onUpdateRandomMin(newValue: UInt) {
        randomMin = newValue
    }
    
    func restartGame(gameComplete: Bool = false) {
        if let validRandomMin = randomMin,
            let validRandomMax = randomMax {
            randomNumber = UInt.random(in: validRandomMin...validRandomMax)
        }
        if gameComplete {
            gamesCount += 1
            averageAttempts = averageAttempts > 0
                ? (averageAttempts + Float(attemptsCount)) / 2
                : Float(attemptsCount)
        }
        attemptsCount = 0
    }
}

