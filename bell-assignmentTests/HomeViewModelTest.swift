//
//  HomeViewModelTest.swift
//  bell-assignmentTests
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import XCTest
@testable import bell_assignment

@MainActor
final class HomeViewModelTest: XCTestCase {

    var homeViewModel: HomeViewModel!
    
    var mockRepository: MockCarRepository!
    
    var mockCars: [Car] = [Car(consList: ["Very bad condition","Smoke"], customerPrice: 5000, make: "BMW", marketPrice: 7000, model: "M1", image: "", prosList: ["easy repair", "fuel economy"], rating: 2), Car(consList: ["Very bad condition","Smoke"], customerPrice: 5000, make: "Honda", marketPrice: 7000, model: "civic", image: "", prosList: ["easy repair", "fuel economy"], rating: 2)]
    
     override func setUp() {
        super.setUp()
        mockRepository = MockCarRepository()
        homeViewModel = HomeViewModel(repository: mockRepository)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    func testGetAllCars() {
        mockRepository.car = mockCars
        
        Task.init {
            await self.homeViewModel.getAllCars()
        }
        
        let expectation = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.first?.make == "BMW"
                    }), object: nil
                )
                wait(for: [expectation], timeout: 5)
    }
    
    func testGetMakes() {
        mockRepository.car = mockCars
        Task.init {
            await self.homeViewModel.getAllCars()
        }
        
        let expectation = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.getMakes().first == "BMW"
                    }), object: nil
                )
                wait(for: [expectation], timeout: 2)
    }
    
    func testGetModels() {
        mockRepository.car = mockCars
        Task.init {
            await self.homeViewModel.getAllCars()
        }
        
        let expectation = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.getModels().first == "M1"
                    }), object: nil
                )
                wait(for: [expectation], timeout: 5)
        
        self.homeViewModel.selectedMake = "Honda"
        
        let expectation2 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.getModels().first == "civic"
                    }), object: nil
                )
                wait(for: [expectation2], timeout: 5)
    }
    
    func testDidSelectMake() {
        mockRepository.car = []
        mockRepository.car = mockCars
        Task.init {
            await self.homeViewModel.getAllCars()
        }
        self.homeViewModel.didSelectMake(make: "Honda")
        let expectation1 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.last?.model == "civic"
                    }), object: nil
                )
                wait(for: [expectation1], timeout: 5)
        
        self.homeViewModel.didSelectMake(make: nil)
        let expectation2 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.count == 2
                    }), object: nil
                )
                wait(for: [expectation2], timeout: 5)
        
        
        self.homeViewModel.selectedModel = "M1"
        self.homeViewModel.didSelectMake(make: "Honda")
        let expectation3 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.count == 0
                    }), object: nil
                )
                wait(for: [expectation3], timeout: 5)
        
        self.homeViewModel.selectedModel = nil
        self.homeViewModel.didSelectMake(make: "Honda")
        let expectation4 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.last?.model == "civic"
                    }), object: nil
                )
                wait(for: [expectation4], timeout: 5)
    }
    
    func testDidSelectModel() {
        mockRepository.car = []
        mockRepository.car = mockCars
        Task.init {
            await self.homeViewModel.getAllCars()
        }
        
        self.homeViewModel.selectedMake = nil
        self.homeViewModel.didSelectModel(model: "M1")
        let expectation1 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.last?.make == "Honda"
                    }), object: nil
                )
                wait(for: [expectation1], timeout: 5)
        
        self.homeViewModel.selectedMake = nil
        self.homeViewModel.didSelectModel(model: nil)
        let expectation2 = XCTNSPredicateExpectation(
                    predicate: NSPredicate(block: { _, _ in
                        
                        self.homeViewModel.presentableCars.count == 2
                    }), object: nil
                )
                wait(for: [expectation2], timeout: 5)
    }

}
