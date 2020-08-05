//
//  LibraryFeatureViewConvertible.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import UIKit

protocol LibraryFeatureViewConvertible where Self: UIViewController {

    static func instantiate() -> Self
}

extension LibraryFeatureViewConvertible {
    
    static func instantiate() -> Self {
        let viewControllerName = String(describing: Self.self)
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        return storyboard.instantiateViewController(
            withIdentifier: viewControllerName) as! Self
    }
}
