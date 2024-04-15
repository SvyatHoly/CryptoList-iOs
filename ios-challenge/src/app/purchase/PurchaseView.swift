//
//  PurchaseView.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/10/24.
//

import Foundation
import SwiftUI

struct PurchaseView: View {
    @ObservedObject var viewModel: PurchaseViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let crypto = viewModel.selectedCurrency {
                    Group {
                        Text("Name: \(crypto.name)")
                        Text("Symbol: \(crypto.symbol)")
                        Text("Rank: \(crypto.rank)")
                        Text("Max Supply: \(crypto.maxSupply ?? 0.0)")
                        Text("Supply: \(crypto.supply ?? 0.0)")
                        Text("Market Cap: \(crypto.marketCapUsd ?? 0.0) USD")
                        Text("Volume (24Hr): \(crypto.volumeUsd24Hr ?? 0.0) USD")
                        Text("Price: \(crypto.priceUsd ?? 0.0) USD")
                        Text("Change (24Hr): \(crypto.changePercent24Hr ?? 0.0)%")
                        Text("VWAP (24Hr): \(crypto.vwap24Hr ?? 0.0)")
                    }
                    .padding(.bottom)
                    
                    TextField("Amount to purchase", text: $viewModel.purchaseAmount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    
                    Button("Buy") {
                        viewModel.buyCrypto()
                    }
                    .padding(.top)
                } else {
                    Text("No cryptocurrency selected")
                }
            }
            .padding()
            .navigationBarTitle("Purchase", displayMode: .inline)
        }
    }
}

