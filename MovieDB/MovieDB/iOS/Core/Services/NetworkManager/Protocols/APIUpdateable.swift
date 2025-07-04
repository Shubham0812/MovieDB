//
//  APIUpdateable.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import SwiftUI

protocol APIUpdatable: AnyObject {
    var errorMessage: String? { get set }

    func apply<T, U>( _ result: Result<T, APIError>, transform: ((T) -> U)?, to keyPath: ReferenceWritableKeyPath<Self, U>)
}

extension APIUpdatable {
    func apply<T, U>( _ result: Result<T, APIError>, transform: ((T) -> U)? = nil, to keyPath: ReferenceWritableKeyPath<Self, U>) {
        switch result {
        case .success(let value):
            let finalValue = transform?(value) ?? (value as! U)
            self[keyPath: keyPath] = finalValue
            
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
    
    
    func apply<T>(_ result: Result<T, APIError>, to keyPath: ReferenceWritableKeyPath<Self, T?>) {
        switch result {
        case .success(let data):
            self[keyPath: keyPath] = data
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
    }
}
