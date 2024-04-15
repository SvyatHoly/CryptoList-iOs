//
//  CryptoListView.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/10/24.
//

import Foundation
import SwiftUI

struct CryptoListView: View {
    @ObservedObject var viewModel = iOSApp.container.resolve(CryptoListViewModel.self)!

    var body: some View {
        NavigationView {
            List(viewModel.data) { currency in
                NavigationLink(destination: PurchaseView(viewModel: PurchaseViewModel(currency: currency))) {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(currency.name)
                                .font(.headline)
                            Spacer()
                            Text(currency.symbol)
                                .foregroundColor(.gray)
                        }
                        HStack {
                            Text("Change: \(currency.changePercent24Hr ?? 0.0, specifier: "%.2f")%")
                                .foregroundColor(currency.changePercent24Hr.map { $0 > 0 ? .green : .red } ?? .black)
                            Spacer()
                            Text("\(currency.priceUsd ?? 0.0, specifier: "%.2f") USD")
                                .bold()
                        }
                    }
                }
            }
            .navigationTitle("Cryptocurrencies")
        }
        .onAppear {
            Task {
                viewModel.loadCurrencies()
            }
        }
        .alert(isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
}

