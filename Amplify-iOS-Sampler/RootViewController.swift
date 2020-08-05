//
//  RootViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 05/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import UIKit
import Amplify

class RootViewController: UITableViewController {

    private var libraries: Array<AmplifyLibrary> = []

    private let identifier = "\(UITableViewCell.self)"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: identifier)
        do {
            self.libraries = try readSampleDefinition().libraries.filter({
                $0.platforms.contains("ios")
                    && AmplifyLibraryType(rawValue: $0.prefix) != nil
            })
        } catch {
            print("Failed read definition error: \(error)")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: identifier,
            for: indexPath)
        cell.textLabel?.text = self.libraries[indexPath.row].name
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return self.libraries.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = LibraryFeatureListViewController.instantiate(
            library: self.libraries[indexPath.row])
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RootViewController {

    enum SampleDefinitionError: Error {
        case cannotReadDefinition
    }
    
    func readSampleDefinition() throws -> SampleDefinition {
        guard let path = Bundle.main.path(forResource: "definition", ofType: "json") else {
            throw SampleDefinitionError.cannotReadDefinition
        }
        let fileURL = URL(fileURLWithPath: path)
        let definitionData = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode(SampleDefinition.self, from: definitionData)
    }
}
