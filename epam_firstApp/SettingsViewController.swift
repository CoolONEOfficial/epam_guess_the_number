//
//  SettingsViewController.swift
//  epam_firstApp
//
//  Created by Nickolay Truhin on 28.01.2020.
//  Copyright © 2020 Nickolay Truhin. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func updateRandomMax(newValue: UInt)
    func updateRandomMin(newValue: UInt)
}

class SettingsViewController: UIViewController {
    
    @IBOutlet var randomMinField: UITextField!
    @IBOutlet var randomMaxField: UITextField!
    
    weak var delegate: SettingsViewControllerDelegate?
    var defaultRandomMax, defaultRandomMin: UInt?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let randomMinText = defaultRandomMin {
            randomMinField.text = String(randomMinText)
        }
        if let randomMaxText = defaultRandomMax {
            randomMaxField.text = String(randomMaxText)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onRandomMinChanged(_ sender: UITextField) {
        if let fieldText = sender.text, !fieldText.isEmpty {
            delegate?.updateRandomMin(newValue: UInt(fieldText) ?? 0)
        }
    }
    
    @IBAction func onRandomMaxChanged(_ sender: UITextField) {
        if let fieldText = sender.text, !fieldText.isEmpty {
            delegate?.updateRandomMax(newValue: UInt(fieldText) ?? 0)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
