//
//  ViewController.swift
//  ProgressHUD
//
//  Created by Sebastian Strus on 2018-06-12.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        perform(#selector(self.addHud), with: nil, afterDelay: 2)
    }


    @objc func addHud() {
        Hud.showOrUpdate(withText: "Reachability check...", andTime: 2.0)
    }
}

