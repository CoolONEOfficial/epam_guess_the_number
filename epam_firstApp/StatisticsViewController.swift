//
//  StatisticsViewController.swift
//  epam_firstApp
//
//  Created by Nickolay Truhin on 28.01.2020.
//  Copyright © 2020 Nickolay Truhin. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    @IBOutlet var gamesCountLabel: UILabel!
    @IBOutlet var attemptsCountLabel: UILabel!
    @IBOutlet var averageAttemptsLabel: UILabel!
    
    var gamesCount: UInt?
    var totalAttemptsCount: UInt?
    var averageAttempts: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let validGamesCount = gamesCount {
            gamesCountLabel.text = String(validGamesCount)
        }
        
        if let validTotalAttemptsCount = totalAttemptsCount {
            attemptsCountLabel.text = String(validTotalAttemptsCount)
        }
        
        if let validAverageAttempts = averageAttempts {
            averageAttemptsLabel.text = String(validAverageAttempts)
        }
        
        // Do any additional setup after loading the view.
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
