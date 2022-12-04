//
//  CarModel+CoreDataClass.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//
//

import Foundation
import CoreData

@objc(CarModel)
public class CarModel: NSManagedObject {
    func toModel() -> Car {
        let cons = self.consList.map { str in
            str as String
        }
        let pros = self.prosList.map { str in
            str as String
        }
        return Car(consList: cons, customerPrice: self.customerPrice, make: self.make ?? "", marketPrice: self.marketPrice, model: self.model ?? "", image: self.image ?? "", prosList: pros, rating: Int(self.rating))
        
    }
}
