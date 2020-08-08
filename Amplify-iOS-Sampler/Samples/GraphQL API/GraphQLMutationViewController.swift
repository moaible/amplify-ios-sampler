//
//  GraphQLMutationViewController.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 08/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import UIKit
import Amplify

class GraphQLMutationViewController: UIViewController, LibraryFeatureViewConvertible {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createTodo()
    }

    func createTodo() {
        let todo = Todo(name: "\(Date())", description: "todo description")
        _ = Amplify.API.mutate(request: .create(todo)) { event in
            switch event {
            case .success(let result):
                switch result {
                case .success(let todo):
                    print("Successfully created the todo: \(todo)")
                case .failure(let graphQLError):
                    print("Failed to create graphql \(graphQLError)")
                }
            case .failure(let apiError):
                print("Failed to create a todo", apiError)
            }
        }
    }
}
