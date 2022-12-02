//
//  CarServices.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import Foundation

enum CarServiceError: Error {
    case decodingArror
    
    case notFoundError
}

protocol CarService {
    /// Get cars from api
    ///
    /// - Parameter value: none
    /// - Returns: List of cars
    func getAllCars() async throws -> [Car]
}

class CarServiceImplementation: CarService {
    
    
    func getAllCars() async throws -> [Car] {
        guard let path = Bundle.main.url(forResource: "car_list", withExtension: "json") else {
            throw CarServiceError.notFoundError
        }
        
        
        do {
            let data = try Data(contentsOf: path)
            let carList =  try JSONDecoder().decode([Car].self,from: data)
            return carList
            
        } catch {
            throw CarServiceError.decodingArror
        }
    }
    
}




