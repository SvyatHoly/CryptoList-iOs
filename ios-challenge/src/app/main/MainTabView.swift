//
//  ContentView.swift
//  ios-challenge
//
//  Created by Marc Flores on 10/4/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CryptoListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }

            TransactionsView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Transactions")
                }
        }
    }
}
#Preview {
    MainTabView()
}
