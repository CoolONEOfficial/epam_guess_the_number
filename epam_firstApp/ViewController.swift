//
//  ViewController.swift
//  epam_firstApp
//
//  Created by Nickolay Truhin on 26.01.2020.
//  Copyright © 2020 Nickolay Truhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Wrap lines prefs
        titleLabel.contentMode = .scaleToFill
        titleLabel.numberOfLines = 0
        
        attemptButton.isEnabled = false
        randomMax = UInt(UserDefaults.standard.integer(forKey: ViewController.randomMaxKey))
        randomMin = UInt(UserDefaults.standard.integer(forKey: ViewController.randomMinKey))
        gamesCount = UInt(UserDefaults.standard.integer(forKey: ViewController.gamesCountKey))
        
        attemptButton.setTitle(
            "Attempt \(attemptsCount + 1)",
            for: .normal
        )
    }

    @IBAction func onAttemptClicked(_ sender: Any) {
        let inputNumber = Int(numberTextField.text!)!
        
        var labelStr: String
        if inputNumber > randomNumber! {
            labelStr = "Too much"
            attemptsCount += 1
        } else if inputNumber < randomNumber! {
            labelStr = "Too small"
            attemptsCount += 1
        } else {
            labelStr = "You win using \(attemptsCount + 1) \(attemptsCount > 0 ? "attempts" : "attempt"). Random number regenerated."
            restartGame()
        }
        
        titleLabel.text = labelStr
    }
    
    var randomNumber: UInt?
    
    private var _attemptsCount: UInt = 0
    var attemptsCount: UInt {
        set(newValue) {
            attemptButton.setTitle(
                "Attempt \(newValue + 1)",
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
    
    static let randomMaxKey = "randMax",
                randomMinKey = "randMin"
    private var _randomMax: UInt?,
                _randomMin: UInt?
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
    
    func onRangeChanged() {
        if randomMin != nil && randomMax != nil {
            titleLabel.text = "Enter number (\(randomMin!)-\(randomMax!))"
            attemptButton.isEnabled = true
            restartGame()
        } else {
            titleLabel.text = "Enter settings to start game"
            attemptButton.isEnabled = false
        }
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
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var attemptButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
}

