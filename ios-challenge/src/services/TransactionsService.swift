//
//  TransactionsService.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/11/24.
//

import Foundation
import Combine

final class TransactionsService {
    
    private let transactionsState: TransactionsStateOwner
    private var bag = Set<AnyCancellable>()
    private var purchasedTransactions = [Transaction]()
    private var totalPriceUsd = 0.0
    
    init(
        transactionsState: TransactionsStateOwner
    ) {
        self.transactionsState = transactionsState
        
        transactionsState.input
            .compactMap { $0 }
            .sink { [unowned self] (action) in
                switch action {
                case let .purchase(amount, currency):
                    guard let priceUsd = currency.priceUsd else { return }
                    let transaction = Transaction(
                        date: .now,
                        usdValue: priceUsd * amount,
                        cryptoAmount: amount,
                        cryptoSymbol: currency.symbol,
                        priceUsd: priceUsd)
                    purchasedTransactions.append(transaction)
                    totalPriceUsd += transaction.usdValue
                    transactionsState.output.send(TransactionsStateOutput(totalPriceUsd: totalPriceUsd, transactions: purchasedTransactions))
                }
            }
            .store(in: &bag)
    }
}
