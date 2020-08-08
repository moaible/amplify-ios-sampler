//
//  LibraryFeatures.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import UIKit

enum AmplifyLibraryType: String {
    case analytics = "Analytics"
}

func libraryFeatures(libraryPrefix: String) -> [String] {
    guard let type = AmplifyLibraryType(rawValue: libraryPrefix) else {
        return []
    }
    switch type {
    case .analytics:
        return [
            "RecordEvent",
            "GlobalProperties"
        ]
    }
}
