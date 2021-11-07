//
//  Airport+CoreDataProperties.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 11/7/21.
//
//

import Foundation
import CoreData


extension Airport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Airport> {
        return NSFetchRequest<Airport>(entityName: "Airport")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var icao: String?
    @NSManaged public var iata: String?
    @NSManaged public var municipality: String?

}

extension Airport : Identifiable {

}
