//
//  Promise+AmplifyAPI.swift
//  Amplify-iOS-Sampler
//
//  Created by Motodera, Hiromi on 10/08/2020.
//  Copyright © 2020 Motodera, Hiromi. All rights reserved.
//

import Foundation
import Amplify
import Hydra

enum RequestOperation<M: Model> {
    case create(_ model: M)
    case update(_ model: M, where: QueryPredicate? = nil)
    case delete(_ model: M, where: QueryPredicate? = nil)
}

enum RequestOperationByQueryGet<M: Model> {
    case get(_ schemaType: M.Type, byId: String)
}

enum RequestOperationByQueryList<M: Model> {
    case getAll(_ schemaType: M.Type, where: QueryPredicate? = nil)
}

@discardableResult
func requestByGraphQL<M: Model>(
    _ requestOperation: RequestOperation<M>,
    _ listener: GraphQLOperation<M>.ResultListener? = nil) -> Promise<M>
{
    return Promise { (resolve, reject, status) in
        switch requestOperation {
        case .create(let model):
            _ = Amplify.API.mutate(request: .create(model)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let createdModel):
                        resolve(createdModel)
                    case .failure(let error):
                        reject(error)
                    }
                case .failure(let error):
                    reject(error)
                }
            }
        case .update(let model, where: let predicate):
            _ = Amplify.API.mutate(request: .update(model, where: predicate)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let updatedModel):
                        resolve(updatedModel)
                    case .failure(let error):
                        reject(error)
                    }
                case .failure(let error):
                    reject(error)
                }
            }
        case .delete(let model, where: let predicate):
            _ = Amplify.API.mutate(request: .delete(model, where: predicate)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let updatedModel):
                        resolve(updatedModel)
                    case .failure(let error):
                        reject(error)
                    }
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}

@discardableResult
func requestByGraphQL<M: Model>(
    _ requestOperation: RequestOperationByQueryGet<M>,
    _ listener: GraphQLOperation<M>.ResultListener? = nil) -> Promise<M?>
{
    return Promise { (resolve, reject, status) in
        switch requestOperation {
        case .get(let schemeType, byId: let id):
            _ = Amplify.API.query(request: .get(schemeType, byId: id)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let items):
                        resolve(items)
                    case .failure(let error):
                        reject(error)
                    }
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}

@discardableResult
func requestByGraphQL<M: Model>(
    _ requestOperation: RequestOperationByQueryList<M>,
    _ listener: GraphQLOperation<M>.ResultListener? = nil) -> Promise<[M]>
{
    return Promise { (resolve, reject, status) in
        switch requestOperation {
        case .getAll(let schemeType, where: let predicate):
            _ = Amplify.API.query(request: .list(schemeType, where: predicate)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let items):
                        resolve(items)
                    case .failure(let error):
                        reject(error)
                    }
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
}
