//
//  AnalyticsGlobalPropertiesViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 06/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import UIKit
import Amplify

class AnalyticsGlobalPropertiesViewController: UIViewController, LibraryFeatureViewConvertible {
    
    private let cellIdentifier = "\(UITableViewCell.self)"
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    func addGlobalProperties(properties: AnalyticsProperties) {
        properties.forEach { (key, value) in
            InMemoryGlobalProperties.shared.add(forKey: key, value: value)
        }
    }
    
    func deleteGlobalProperty(key: String) {
        InMemoryGlobalProperties.shared.delete(forKey: key)
    }
    
    func deleteAllGlobalProperties() {
        InMemoryGlobalProperties.shared.deleteAll()
    }
}

extension AnalyticsGlobalPropertiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InMemoryGlobalProperties.shared.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let key = InMemoryGlobalProperties.shared.keys[indexPath.row]
        guard let property = InMemoryGlobalProperties.shared.properties[key] else {
            fatalError()
        }
        cell.textLabel?.text = "\(key): \(property)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
