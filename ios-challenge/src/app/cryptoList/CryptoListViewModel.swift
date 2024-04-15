//
//  CryptoListModel.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/10/24.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    @Published var data: [CryptoCurrency] = []
    @Published var transactions: [Transaction] = []
    @Published var errorMessage: String? = nil
    
    private let service: CoincapService
    
    init(service: CoincapService) {
        self.service = service
    }

    func loadCurrencies() {
        Task {
            let result = await service.fetchCurrencies()
            switch result {
            case .success(let currencies):
                DispatchQueue.main.async {
                    self.data = currencies
                    self.errorMessage = nil
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.data = []
                    self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                }
            }
        }
    }
    
    
    func addTransaction(usdValue: Double, cryptoAmount: Double, cryptoSymbol: String, priceUsd: Double) {
        let transaction = Transaction(date: Date(), usdValue: usdValue, cryptoAmount: cryptoAmount, cryptoSymbol: cryptoSymbol, priceUsd: priceUsd)
        transactions.append(transaction)
    }
}
