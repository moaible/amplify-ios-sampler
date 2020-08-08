//
//  InMemoryGlobalProperties.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 08/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import Amplify
import AmplifyPlugins

struct InMemoryGlobalProperties {
    private var data: AnalyticsProperties = [:]
    static var shared: InMemoryGlobalProperties = InMemoryGlobalProperties()
    private init() {}

    var keys: [Dictionary<String, AnalyticsPropertyValue>.Keys.Element] {
        return Array(data.keys)
    }
    
    var properties: AnalyticsProperties {
        return data
    }
    
    mutating func add(forKey key: String, value: AnalyticsPropertyValue) {
        self.data[key] = value
        Amplify.Analytics.registerGlobalProperties([key : value])
    }
    
    mutating func delete(forKey keys: [String]) {
        keys.forEach({ (key) in
            self.delete(forKey: key)
        })
    }
    
    mutating func delete(forKey key: String) {
        self.data.removeValue(forKey: key)
        Amplify.Analytics.unregisterGlobalProperties([key])
    }
    
    mutating func deleteAll() {
        self.data = [:]
        Amplify.Analytics.unregisterGlobalProperties()
    }
}
