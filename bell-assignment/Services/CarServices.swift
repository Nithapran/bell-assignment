//
//  CarServices.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import Foundation

enum CarServicesError: Error {
    case decodingArror
    case notFoundError
}

protocol CarServices {
    func getAllCars() async throws -> [Car]
}

class CarServicesImplementation: CarServices {
    func getAllCars() async throws -> [Car] {
        guard let path = Bundle.main.url(forResource: "car_list", withExtension: "json") else {
            throw CarServicesError.notFoundError
        }
        
        
        do {
            let data = try Data(contentsOf: path)
            let carList =  try JSONDecoder().decode([Car].self,from: data)
            return carList
            
        } catch {
            throw CarServicesError.decodingArror
        }
    }
    
}




