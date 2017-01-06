//
//  SettingsViewController.swift
//  Flicks
//
//  Created by Daniel Ku on 1/6/17.
//  Copyright © 2017 djku. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var saveSettings: UIButton!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.tintColor = UIColor.white
        
        saveSettings.layer.borderWidth = 0
        saveSettings.layer.masksToBounds = false
        saveSettings.layer.cornerRadius = saveSettings.frame.height/6
        saveSettings.clipsToBounds = true
        
        let defaults = UserDefaults.standard
        if let sort = defaults.string(forKey: "sortControl"){
            sortControl = sort
        }
        
        if sortControl == "NowPlaying"{
            sortSegmentedControl.selectedSegmentIndex = 0
        }else if sortControl == "Popular"{
            sortSegmentedControl.selectedSegmentIndex = 1
        }else if sortControl == "TopRated"{
            sortSegmentedControl.selectedSegmentIndex = 2
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveSettingsButton(_ sender: Any) {
        if sortSegmentedControl.selectedSegmentIndex == 0{
            sortControl = "NowPlaying"
        }else if sortSegmentedControl.selectedSegmentIndex == 1{
            sortControl = "Popular"
        }else if sortSegmentedControl.selectedSegmentIndex == 2{
            sortControl = "TopRated"
        }
        
        let defaults = UserDefaults.standard
        defaults.set(sortControl, forKey: "sortControl")
        defaults.synchronize()
    }


}
