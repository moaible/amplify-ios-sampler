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

    private var library: AmplifyLibrary!
    private var features: [String] = []
    private let identifier = "\(UITableViewCell.self)"

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
        instance.features = libraryFeatures(libraryPrefix: library.prefix)
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = library?.name
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
        cell.textLabel?.text = self.features[indexPath.row]
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return self.features.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if let featureViewController = faetureViewController(self.features[indexPath.row]) {
            self.navigationController?.pushViewController(featureViewController, animated: true)
        }
    }

    private func faetureViewController(_ featureName: String) -> LibraryFeatureViewConvertible? {
        let feature = featureName
        guard let projectNameRef = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") else {
            return nil
        }
        let projectName = String(describing: projectNameRef)
        let className = "\(projectName).\(library.prefix)\(feature)ViewController"
            .replacingOccurrences(of: "-", with: "_")
        return (NSClassFromString(className) as? LibraryFeatureViewConvertible.Type)?.instantiate()
    }
}
