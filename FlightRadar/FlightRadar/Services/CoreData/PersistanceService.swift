//
//  PersistanceService.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
import CoreData
import RxSwift

protocol PersistanceService {
    func add(airport: AirportModel)
    func fetchAirports() -> Single<[AirportModel]>
    init(containerName: String)
}

final class CoreDataService: NSObject, PersistanceService {
    let managedObjectContext: NSManagedObjectContext
    let persistentContainer: NSPersistentContainer
    func add(airport: AirportModel) {
        
    }
    func fetchAirports() -> Single<[AirportModel]> {
        let managedContext = managedObjectContext
        return Single.create { promise in
            let fetchRequest = NSAsynchronousFetchRequest(fetchRequest: Favorites.fetchRequest()) { result in
                let airportSet = result.finalResult?.first?.airports as? Set<Airport>
                if let airportSet = airportSet {
                    let array = Array(airportSet)
                    let airports = array.map({ AirportModel(icao: $0.icao, iata: $0.iata, name: $0.name, municipalityName: $0.municipality, latitude: $0.latitude, longitude: $0.longitude)})
                    promise(.success(airports))
                }
                else {
                    promise(.success([]))
                }
                
            }
            do {
                try managedContext.execute(fetchRequest)
            } catch let error {
                promise(.failure(error))
            }
            return Disposables.create()
        }
        
    }
    
    
    init(containerName: String) {
        persistentContainer = NSPersistentContainer(name: containerName)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        managedObjectContext = persistentContainer.newBackgroundContext()
    }
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
