//
//  Container+RegisterServicies.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/12/24.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerServices() {
        autoregister(TransactionsService.self, initializer: TransactionsService.init).inObjectScope(.container)
        autoregister(CoincapService.self, initializer: CoincapService.init).inObjectScope(.container)
    }
}
