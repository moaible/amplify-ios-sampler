//
//  RootViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import UIKit
import Amplify

class RootViewController: UITableViewController {

    private let identifier = "\(UITableViewCell.self)"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: identifier)
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
