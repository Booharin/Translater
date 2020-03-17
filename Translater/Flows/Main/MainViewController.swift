//
//  MainViewController.swift
//  Translater
//
//  Created by 18421820 on 17.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        self.navigationController?.navigationBar.isHidden = true
    }
}
