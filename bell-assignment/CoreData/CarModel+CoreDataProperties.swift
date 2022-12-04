//
//  CarModel+CoreDataProperties.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//
//

import Foundation
import CoreData


extension CarModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarModel> {
        return NSFetchRequest<CarModel>(entityName: "CarModel")
    }

    @NSManaged public var prosList: [NSString]
    @NSManaged public var consList: [NSString]
    @NSManaged public var customerPrice: Double
    @NSManaged public var make: String?
    @NSManaged public var marketPrice: Double
    @NSManaged public var model: String?
    @NSManaged public var image: String?
    @NSManaged public var rating: Int64

}

extension CarModel : Identifiable {

}
