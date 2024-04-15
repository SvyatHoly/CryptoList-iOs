//
//  Container+States.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/12/24.
//

import Foundation

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerStates() {
        autoregister(TransactionsStateOwner.self, initializer: TransactionsStateOwnerImpl.init).inObjectScope(.container)
        autoregister(TransactionsState.self, initializer: TransactionsStateImpl.init).inObjectScope(.container)
    }
}
