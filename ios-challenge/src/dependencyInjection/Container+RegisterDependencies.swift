//
//  Container+RegisterDependencies.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/12/24.
//

import Swinject

extension Container {
    func registerDependencies() {
        registerServices()
        registerViewModels()
        registerStates()
    }
}
