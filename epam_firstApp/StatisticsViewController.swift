//
//  StatisticsViewController.swift
//  epam_firstApp
//
//  Created by Nickolay Truhin on 28.01.2020.
//  Copyright © 2020 Nickolay Truhin. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        gamesCountLabel.text = String(gamesCount ?? 0)
        
        // Do any additional setup after loading the view.
    }
    
    var gamesCount: UInt?
    
    @IBOutlet var gamesCountLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
