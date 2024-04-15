//
//  TransactionsState.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/11/24.
//

import Foundation
import Combine

enum TransactionsStateAction {
    case purchase(amount: Double, currency: CryptoCurrency)
}

protocol TransactionsStateOwner {
    var output: CurrentValueSubjectS<TransactionsStateOutput?>  { get }
    var input: CurrentValueSubjectS<TransactionsStateAction?> { get }
}

final class TransactionsStateOwnerImpl: TransactionsStateOwner {

    let output: CurrentValueSubjectS<TransactionsStateOutput?> = .init(nil)
    let input: CurrentValueSubjectS<TransactionsStateAction?> = .init(nil)
}

protocol TransactionsState {
    var output: AnyPublisherS<TransactionsStateOutput?> { get }
    var input: CurrentValueSubjectS<TransactionsStateAction?> { get }
}

final class TransactionsStateImpl: TransactionsState {

    let owner: TransactionsStateOwner

    init(owner: TransactionsStateOwner) {
        self.owner = owner
    }

    var output: AnyPublisherS<TransactionsStateOutput?> {
        owner.output.eraseToAnyPublisher()
    }
    
    var input: CurrentValueSubjectS<TransactionsStateAction?> {
        owner.input
    }
}
