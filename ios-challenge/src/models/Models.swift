//
//  Models.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/10/24.
//

import Foundation


struct CryptoCurrencyRequest: Codable {
    let data: [CryptoCurrency]
    let timestamp: Int
}

struct TransactionsStateOutput {
    let totalPriceUsd: Double
    let transactions: [Transaction]
}

struct CryptoCurrency: Codable, Identifiable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: Double?
    let maxSupply: Double?
    let marketCapUsd: Double?
    let volumeUsd24Hr: Double?
    let priceUsd: Double?
    let changePercent24Hr: Double?
    let vwap24Hr: Double?
    let explorer: URL?
    
    enum CodingKeys: String, CodingKey {
        case id, rank, symbol, name, explorer
        case supply, maxSupply, marketCapUsd, volumeUsd24Hr, priceUsd, changePercent24Hr, vwap24Hr
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        rank = try container.decode(String.self, forKey: .rank)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)
        
        supply = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .supply))
        maxSupply = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .maxSupply))
        marketCapUsd = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .marketCapUsd))
        volumeUsd24Hr = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .volumeUsd24Hr))
        priceUsd = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .priceUsd))
        changePercent24Hr = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .changePercent24Hr))
        vwap24Hr = CryptoCurrency.toDouble(try? container.decode(String.self, forKey: .vwap24Hr))
        explorer = try? container.decode(URL.self, forKey: .explorer)
    }
    
    init(
        id: String,
        rank: String,
        symbol: String,
        name: String,
        supply: Double?,
        maxSupply: Double?,
        marketCapUsd: Double?,
        volumeUsd24Hr: Double?,
        priceUsd: Double?,
        changePercent24Hr: Double?,
        vwap24Hr: Double?,
        explorer: URL?
    ) {
        self.id = id
        self.rank = rank
        self.symbol = symbol
        self.name = name
        self.supply = supply
        self.maxSupply = maxSupply
        self.marketCapUsd = marketCapUsd
        self.volumeUsd24Hr = volumeUsd24Hr
        self.priceUsd = priceUsd
        self.changePercent24Hr = changePercent24Hr
        self.vwap24Hr = vwap24Hr
        self.explorer = explorer
    }
    
    
    private static func toDouble(_ string: String?) -> Double? {
        if let string = string {
            return Double(string)
        }
        return nil
    }
}



struct Transaction: Identifiable {
    var id: UUID = UUID()
    var date: Date
    var usdValue: Double
    var cryptoAmount: Double
    var cryptoSymbol: String
    var priceUsd: Double
}
