//
//  ViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import UIKit
import Amplify

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try Amplify.configure()
            Amplify.Logging.logLevel = .verbose
        } catch {
            print(error)
        }
    }
}
