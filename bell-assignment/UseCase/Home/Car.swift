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
        return String(format: "%.0f k", marketPrice/1000)
    }
    
    func getProsList() -> [String] {
        return prosList.filter { $0 != ""  }
    }
    
    func getConsList() -> [String] {
        return consList.filter { $0 != ""  }
    }
}
