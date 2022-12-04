//
//  CarRepository.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import Foundation

protocol CarRepository {
    func getAllCars() async throws -> [Car]
}

class CarDataRepository: CarRepository {
    
    
    private let remoteDataSource: CarDataSource
    private let localDataSource: CarDataSource
    
    init(remoteDataSource: CarDataSource, localDataSource: CarDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getAllCars() async throws -> [Car] {
        let carList = try await localDataSource.getAllCars()
        if carList.count > 0 {
            return carList
        } else {
            let carList = try await remoteDataSource.getAllCars()
            for car in carList {
                _ = await self.addcar(car: car)
            }
            return carList
        }
    }
    
    private func addcar(car: Car) async -> Car? {
        
                let car = await localDataSource.addcar(car: car)
            return car
       
    }
}
