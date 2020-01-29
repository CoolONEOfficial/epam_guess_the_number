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
        
        get {
            return _attemptsCount
        }
    }
    
    static let gamesCountKey = "gamesCount"
    private var _gamesCount: UInt?
    var gamesCount: UInt? {
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
        if let defRandomMax = userDefs.object(forKey: ViewController.randomMaxKey),
            let defRandomMin = userDefs.object(forKey: ViewController.randomMinKey),
            defRandomMax is Int,
            defRandomMin is Int {
            randomMax = UInt(defRandomMax as! Int)
            randomMin = UInt(defRandomMin as! Int)
        }
        gamesCount = UInt(userDefs.integer(forKey: ViewController.gamesCountKey))
        attemptsCount = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "settingsSegue":
            let controller =  segue.destination as! SettingsViewController
            controller.defaultRandomMax = randomMax
            controller.defaultRandomMin = randomMin
            controller.delegate = self
        case "statisticsSegue":
            let controller =  segue.destination as! StatisticsViewController
            controller.gamesCount = gamesCount
        default: break
        }
    }

    @IBAction func onAttemptClicked(_ sender: Any) {
        let inputNumber = Int(numberTextField.text!)
        
        if let validInputNumber = inputNumber {
            var labelStr: String
            if validInputNumber > randomNumber! {
                labelStr = NSLocalizedString("tooMuch", comment: "")
                attemptsCount += 1
            } else if inputNumber! < randomNumber! {
                labelStr = NSLocalizedString("tooSmall", comment: "")
                attemptsCount += 1
            } else {
                labelStr = String.localizedStringWithFormat(
                    NSLocalizedString("win", comment: ""),
                    attemptsCount + 1
                )
                restartGame()
            }
            
            titleLabel.text = labelStr
        }
    }
    
    func onRangeChanged() {
        if randomMin != nil && randomMax != nil {
            titleLabel.text = String.localizedStringWithFormat(
                NSLocalizedString("enterNumber", comment: ""),
                randomMin!,
                randomMax!
            )
            attemptButton.isEnabled = true
            restartGame()
        } else {
            titleLabel.text = NSLocalizedString("setSettings", comment: "")
            attemptButton.isEnabled = false
        }
    }
    
    func updateRandomMax(newValue: UInt) {
        randomMax = newValue
    }
    
    func updateRandomMin(newValue: UInt) {
        randomMin = newValue
    }
    
    func restartGame() {
        randomNumber = UInt.random(in: randomMin!...randomMax!)
        attemptsCount = 0
        if gamesCount != nil {
            gamesCount! += 1
        }
    }
}

