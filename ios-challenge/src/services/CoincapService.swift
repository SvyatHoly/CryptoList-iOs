//
//  CoincapService.swift
//  ios-challenge
//
//  Created by Sviatoslav Ivanov on 4/10/24.
//

import Foundation
import Alamofire

class CoincapService {
    func fetchCurrencies() async -> Result<[CryptoCurrency], Error> {
        let url = "https://api.coincap.io/v2/assets"
        do {
            let response = try await AF.request(url).serializingDecodable(CryptoCurrencyRequest.self).value
            return .success(response.data)
        } catch {
            return .failure(error)
        }
    }
}
