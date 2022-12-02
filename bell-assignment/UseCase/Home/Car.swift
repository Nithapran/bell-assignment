//
//  Car.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import Foundation

struct Car: Codable {
    var consList: [String]
    var customerPrice: Double
    var make: String
    var marketPrice: Double
    var model: String
    var image: String
    var prosList: [String]
    var rating: Int
    
    func getPriceInKFormat() -> String {
        return "\( marketPrice/1000)k"
    }
}
