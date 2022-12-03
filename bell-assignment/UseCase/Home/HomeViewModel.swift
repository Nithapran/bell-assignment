//
//  HomeViewModel.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import Foundation

@MainActor
class HomeViewModel {
    let service: CarService
    
    /// Array of cars
    var cars: [Car] = []
    
    
    /// Called after fetch car from service
    var didFetchCar: (() -> Void)?
    
    /// HomeViewModel initialiser
    ///
    /// - Parameter value: service: CarService type
    /// - Returns: none
    init(service: CarService) {
        self.service = service
    }
    
    /// Get cars from api
    ///
    /// - Parameter value: none
    /// - Returns: none
    func getAllCars() {
        
        Task.init {
            do {
                let carList = try await service.getAllCars()
                self.cars = carList
                
                    self.didFetchCar?()
                
                
            } catch {
                if let err = error as? CarServiceError {
                    switch err {
                    case .decodingArror:
                        print("decoding error")
                    case .notFoundError:
                        print("json not found")
                    }
                }
                
            }
        }
        
    }
}
