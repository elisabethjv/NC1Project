//
//  GameOverViewController.swift
//  NC1Project
//
//  Created by Elisabeth Jessica Valencia on 20/05/19.
//  Copyright © 2019 Elisabeth Jessica Valencia. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBAction func Replay(_ sender: Any) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    // cara supaya status bar nya jadi light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
