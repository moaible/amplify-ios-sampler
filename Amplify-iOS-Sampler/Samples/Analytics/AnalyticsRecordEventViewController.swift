//
//  AnalyticsRecordEventViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import UIKit
import Amplify

class AnalyticsRecordEventViewController: UIViewController, LibraryFeatureViewConvertible {

    @IBOutlet weak var analyticsEnabledSwitch: UISwitch!
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var recordEventButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private let cellIdentifier = "\(UITableViewCell.self)"
    
    var analyticsProperties: AnalyticsProperties = [
        "eventPropertyStringKey": "eventPropertyStringValue",
        "eventPropertyIntKey": 123,
        "eventPropertyDoubleKey": 12.34,
        "eventPropertyBoolKey": true
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        analyticsEnabledSwitch.setOn(true, animated: false)
        enableAnalyticsSwitch(isEnabled: true)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        eventNameField.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func changeAnalyticsEnableSwitch(_ sender: UISwitch) {
        enableAnalyticsSwitch(isEnabled: sender.isOn)
    }
    
    @IBAction func touchRecordEventButton(_ sender: UIButton) {
        if let eventName = eventNameField?.text, !eventName.isEmpty {
            self.recordEvents(name: eventName)
        }
    }
    
    private func enableAnalyticsSwitch(isEnabled: Bool) {
        isEnabled ? Amplify.Analytics.enable() : Amplify.Analytics.disable()
    }

    func recordEvents(name: String) {
        Amplify.Analytics.record(event:
            BasicAnalyticsEvent(name: name, properties: self.analyticsProperties))
        eventNameField.text = nil
    }
}

extension AnalyticsRecordEventViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return analyticsProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let key = Array(analyticsProperties.keys)[indexPath.row]
        let property = analyticsProperties[key] ?? ""
        cell.textLabel?.text = "\(key): \(property)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension AnalyticsRecordEventViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
