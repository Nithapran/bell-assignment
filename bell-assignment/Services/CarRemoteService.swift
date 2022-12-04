//
//  CarRemoteService.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import Foundation

enum CarRemoteServiceError: Error {
    case decodingArror
    
    case notFoundError
}

protocol CarDataSource {
    /// Get car list
    ///
    /// - Parameter value: none
    /// - Returns: List of cars
    func getAllCars() async throws -> [Car]
    
    /// Get car list
    ///
    /// - Parameter value: none
    /// - Returns: List of cars
    func addcar(car: Car) async -> Car?
}

class CarRemoteService: CarDataSource {
    func addcar(car: Car) async -> Car? {
        return nil
    }
    
    
    
    func getAllCars() async throws -> [Car] {
        guard let path = Bundle.main.url(forResource: "car_list", withExtension: "json") else {
            throw CarRemoteServiceError.notFoundError
        }
        
        
        do {
            let data = try Data(contentsOf: path)
            let carList =  try JSONDecoder().decode([Car].self,from: data)
            return carList
            
        } catch {
            throw CarRemoteServiceError.decodingArror
        }
    }
    
}




