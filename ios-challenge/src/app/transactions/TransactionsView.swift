//
//  TransactionsView.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/12/24.
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var viewModel = iOSApp.container.resolve(TransactionsViewModel.self)!

    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Total Spent: \(viewModel.state?.totalPriceUsd ?? 0, specifier: "%.2f") USD")) {
                    ForEach(viewModel.state?.transactions ?? []) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                }
            }
            .navigationTitle("Transactions")
        }
    }
}

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(transaction.usdValue, specifier: "%.2f") USD => \(transaction.cryptoAmount, specifier: "%.3f") \(transaction.cryptoSymbol)")
                Text("Rate: \(transaction.priceUsd, specifier: "%.2f") USD")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text(transaction.date, style: .date)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
