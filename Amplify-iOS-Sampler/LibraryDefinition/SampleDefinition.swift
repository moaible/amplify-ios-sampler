//
//  SampleDefinition.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation

struct SampleDefinition: Codable {
    let libraries: Array<AmplifyLibrary>
}

struct AmplifyLibrary: Codable {
    let name: String
    let prefix: String
    let platforms: Array<String>
}
