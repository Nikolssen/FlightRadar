//
//  Favorites+CoreDataProperties.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var airports: Airport?

}

extension Favorites : Identifiable {

}
