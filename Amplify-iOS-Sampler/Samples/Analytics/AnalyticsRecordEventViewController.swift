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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        analyticsEnabledSwitch.setOn(true, animated: false)
        enableAnalyticsSwitch(isEnabled: true)
        eventNameField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recordEvents(name: "show")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        recordEvents(name: "close")
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
//        eventNameField.isEnabled = isEnabled
//        recordEventButton.isEnabled = isEnabled
    }

    func recordEvents(name: String) {
        let properties: AnalyticsProperties = [
            "eventPropertyStringKey": "eventPropertyStringValue",
            "eventPropertyIntKey": 123,
            "eventPropertyDoubleKey": 12.34,
            "eventPropertyBoolKey": true
        ]
        Amplify.Analytics.record(event:
            BasicAnalyticsEvent(name: name, properties: properties))
        eventNameField.text = nil
    }
}

extension AnalyticsRecordEventViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
