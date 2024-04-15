//
//  Container+ViewModels.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/12/24.
//

import Swinject
import SwinjectAutoregistration

extension Container {
    func registerViewModels() {
        autoregister(TransactionsViewModel.self, initializer: TransactionsViewModel.init)
        autoregister(PurchaseViewModel.self, initializer: PurchaseViewModel.init)
        autoregister(CryptoListViewModel.self, initializer: CryptoListViewModel.init)
    }
}
