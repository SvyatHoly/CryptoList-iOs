//
//  TransactionsViewModel.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/12/24.
//

import Foundation
import Combine

final class TransactionsViewModel: NSObject, ObservableObject {

    @Published var state: TransactionsStateOutput? = nil

    private let transactionsState: TransactionsState
    private var bag = Set<AnyCancellable>()

    init(transactionsState: TransactionsState) {
        self.transactionsState = transactionsState
        super.init()
        subscribe()
    }
    
    deinit {
        print("deinit")
    }
    
    private func subscribe() {
        transactionsState.output
            .sink { [unowned self] value in
            state = value
        }
        .store(in: &bag)
    }
}
