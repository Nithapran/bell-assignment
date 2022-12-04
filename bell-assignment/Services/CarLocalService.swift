//
//  CarLocalService.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import Foundation
import CoreData

enum CarLocalServiceError: Error {
    case FetchingFailed
    case savingFailed
}

extension CarLocalServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .FetchingFailed:
            return NSLocalizedString(
                "Fetching car failed",
                comment: ""
            )
        case .savingFailed:
            return NSLocalizedString(
                "Saving car failed",
                comment: ""
            )
        }
    }
}


class CarLocalService: CarDataSource {
    let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    
    func getAllCars() async throws->  [Car] {
        let carsFetch: NSFetchRequest<CarModel> = CarModel.fetchRequest()
        
        do {
            let results = try context.fetch(carsFetch)
            var cars: [Car] = []
            for result in results {
                cars.append(result.toModel())
            }
            return cars
        } catch let error as NSError {
            print("Fetch error: \(error) description: \(error.userInfo)")
            throw CarLocalServiceError.FetchingFailed
        }
        
    }
    
    
    
    func addcar(car: Car) async -> Car? {
        let newCar = CarModel(context: context)
        newCar.setValue(car.consList, forKey: #keyPath(CarModel.consList))
        newCar.setValue(car.customerPrice, forKey: #keyPath(CarModel.customerPrice))
        newCar.setValue(car.make, forKey: #keyPath(CarModel.make))
        newCar.setValue(car.marketPrice, forKey: #keyPath(CarModel.marketPrice))
        newCar.setValue(car.model, forKey: #keyPath(CarModel.model))
        newCar.setValue(car.image, forKey: #keyPath(CarModel.image))
        newCar.setValue(car.prosList, forKey: #keyPath(CarModel.prosList))
        newCar.setValue(Int64(car.rating), forKey: #keyPath(CarModel.rating))
        await AppDelegate.sharedAppDelegate.coreDataStack.saveContext() // Save changes in CoreData
        
        return newCar.toModel()
    }
}
