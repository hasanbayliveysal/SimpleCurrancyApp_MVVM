//
//  CurrancyViewModel.swift
//  ValyutaApp
//
//  Created by Veysal on 17.10.22.
//

import Foundation

struct CurrancyRatesViewModel {
    var ratesList : CurrancyRatesModel
}
extension CurrancyRatesViewModel {
    func getPrice(value: String) -> Double {
        return ratesList.rates[value]!
    }
}

struct CurrancyViewModel {
    
    var currancy : CurrancyModel

}

extension CurrancyViewModel {
   
    var base : String {
        return currancy.base
    }
    
    var date : String {
        return currancy.date
    }
}
