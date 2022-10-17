//
//  CurrancyWebService.swift
//  ValyutaApp
//
//  Created by Veysal on 17.10.22.
//

import Foundation

class CurrancyWebService {
    func downloadData(url : URL, complition : @escaping (CurrancyModel?, CurrancyRatesModel?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                print(error.localizedDescription)
                complition(nil,nil)
            } else if let data = data {
                guard let otherData = try? JSONDecoder().decode(CurrancyModel.self, from: data) else {
                    return
                }
                guard let ratesData = try? JSONDecoder().decode(CurrancyRatesModel.self, from: data) else {
                    return
                }
                print("new data: \(otherData)")
                complition(otherData,ratesData)
            }
        }.resume()
    }
}
