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
            GlobalAnalyticsPropertyStore.shared.add(forKey: key, value: value)
        }
        Amplify.Analytics.registerGlobalProperties(properties)
    }
    
    func deleteGlobalProperty(key: String) {
        GlobalAnalyticsPropertyStore.shared.delete(forKey: key)
        Amplify.Analytics.unregisterGlobalProperties([key])
    }
    
    func deleteAllGlobalProperties() {
        GlobalAnalyticsPropertyStore.shared.deleteAll()
        Amplify.Analytics.unregisterGlobalProperties()
    }
}

extension AnalyticsGlobalPropertiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalAnalyticsPropertyStore.shared.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let key = GlobalAnalyticsPropertyStore.shared.keys[indexPath.row]
        guard let property = GlobalAnalyticsPropertyStore.shared.properties[key] else {
            fatalError()
        }
        cell.textLabel?.text = "\(key): \(property)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
