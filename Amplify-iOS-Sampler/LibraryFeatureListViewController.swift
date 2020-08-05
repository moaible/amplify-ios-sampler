//
//  LibraryFeatureListViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import UIKit

class LibraryFeatureListViewController: UITableViewController {

    private var library: AmplifyLibrary?

    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instantiate(library: AmplifyLibrary) -> LibraryFeatureListViewController {
        let instance = LibraryFeatureListViewController()
        instance.library = library
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = library?.name
    }
}
