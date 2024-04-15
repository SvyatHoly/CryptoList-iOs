//
//  PurchaseViewModel.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/10/24.
//

import Foundation

class PurchaseViewModel: ObservableObject {
    @Published var selectedCurrency: CryptoCurrency?
    @Published var purchaseAmount: String = ""

    private let transactionsState = iOSApp.container.resolve(TransactionsState.self)!
    private var convertedAmount: Double? {
        Double(purchaseAmount)
    }

    init(currency: CryptoCurrency? = nil) {
        self.selectedCurrency = currency
    }
    
    func buyCrypto() {
        guard let currency = selectedCurrency else { return }
        
        print("Purchasing \(purchaseAmount) of \(selectedCurrency?.name ?? "")")
        transactionsState.input.send(.purchase(amount: convertedAmount ?? 0.0, currency: currency))
    }
}
