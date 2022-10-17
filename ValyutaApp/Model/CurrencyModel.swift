//
//  CurrencyModel.swift
//  ValyutaApp
//
//  Created by Veysal on 17.10.22.
//

import Foundation

struct CurrancyModel : Decodable {
    var success : Bool
    var base : String
    var date : String
   
}

struct CurrancyRatesModel : Decodable {
    var rates : [String : Double]
}


