//
//  MockCarRepository.swift
//  bell-assignmentTests
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import Foundation
@testable import bell_assignment

class MockCarRepository: CarRepository {
    
    var car: [Car] = []
    
    func getAllCars() async throws -> [Car] {
        return self.car
    }
    
    func addcar(car: Car) async -> Car? {
        
            return nil
       
    }
}
