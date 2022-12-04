//
//  HomeViewModel.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-02.
//

import Foundation

@MainActor
class HomeViewModel {
    private let repository: CarRepository
    
    /// Array of cars
    private var cars: [Car] = []
    
    /// Array of cars used to display
    var presentableCars: [Car] = []
    
    var selectedMake: String?
    
    var selectedModel: String?
    
    /// Called after fetch car from service
    var didFetchCar: (() -> Void)?
    
    /// HomeViewModel initialiser
    ///
    /// - Parameter value: service: CarService type
    /// - Returns: none
    init(repository: CarRepository) {
        self.repository = repository
    }
    
    /// Get cars from api
    ///
    /// - Parameter value: none
    /// - Returns: none
    func getAllCars() async {
        
            do {
                let carList =  try await self.repository.getAllCars()
                self.cars = carList
                self.presentableCars = carList
                self.didFetchCar?()
            } catch CarRemoteServiceError.decodingArror {
                print("decoding error")
            } catch CarRemoteServiceError.notFoundError {
                print("json not found")
            } catch CarLocalServiceError.FetchingFailed {
                print("json not found")
            } catch CarLocalServiceError.savingFailed {
                print("json not found")
            } catch {
                print("Unknow error")
            }
            
        
            
        }
    
    /// Filter make names from the car data
    ///
    /// - Parameter value: none
    /// - Returns: none
    func getMakes() -> [String] {
        let makes = self.cars.map {
            $0.make
        }
        
        return makes
    }
    
    /// Filter model names from the car data
    ///
    /// - Parameter value: none
    /// - Returns: none
    func getModels() -> [String] {
        if let selectedMake = selectedMake {
            let filteredCars = cars.filter {
                $0.make == selectedMake
            }
            let models = filteredCars.map {
                
                $0.model
            }
            return models
        } else {
            let models = self.cars.map {
                
                $0.model
            }
            return models
        }
    }
    
    /// Filter car data according to the selected Make
    ///
    /// - Parameter value: make: Car make
    /// - Returns: none
    func didSelectMake(make: String?) {
        guard let make = make else {
            clearFilters()
            return
        }
        self.selectedMake = make
        filterCars()
        
    }
    
    /// Filter car data according to the selected Model
    ///
    /// - Parameter value: model: Car Model
    /// - Returns: none
    func didSelectModel(model: String?) {
        self.selectedModel = model
        filterCars()
    }
    
    
    private func filterCars() {
        presentableCars = cars.filter {
            if let make = selectedMake {
                if let model = selectedModel {
                    return $0.make == make && $0.model == model
                } else {
                    return $0.make == make
                }
            } else if let model = selectedModel {
                return $0.model == model
            } else {
                return true
            }
        }
    }
    
    private func clearFilters() {
        self.selectedMake = nil
        self.selectedModel = nil
        self.presentableCars = self.cars
    }
    
}
