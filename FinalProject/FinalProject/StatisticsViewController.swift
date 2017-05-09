//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Sebastian Lim on 5/8/17.
//  Copyright © 2017 Harvard Division of Continuing Education. All rights reserved.
//
//  App Icon Credit: https://icons8.com/web-app/47036/runway
//  Tab Bar Icon Credit: https://icons8.com/web-app/5590/settings
//  Tab Bar Icon Credit: https://icons8.com/web-app/5570/picture

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var aliveTextField: UITextField!
    @IBOutlet weak var deadTextField: UITextField!
    
    var engine: StandardEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
