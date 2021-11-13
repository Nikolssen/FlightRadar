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
    
    func remove(airport: AirportModel) {
        guard let iata = airport.iata else { return }
        let fetchRequest = NSFetchRequest<Airport>(entityName: "Airport")
        fetchRequest.predicate = NSPredicate(format: "iata", iata)
        let result = try? managedObjectContext.fetch(fetchRequest)
        guard let result = result, !result.isEmpty else { return }
        result.forEach(managedObjectContext.delete(_:))
        saveContext()
    }
    
    func add(airport: AirportModel) {
        guard !isFavorite(airport: airport),
        let iata = airport.iata
        else { return }
        let entity = Airport(context: managedObjectContext)
        entity.iata = iata
        entity.icao = airport.icao
        entity.name = airport.name
        entity.latitude = airport.location?.lat ?? 360 //Invalid coordinates
        entity.longitude = airport.location?.lon ?? 360
        saveContext()
    }
    
    func isFavorite(airport: AirportModel) -> Bool {
        guard let iata = airport.iata else { return false }
        let fetchRequest = NSFetchRequest<Airport>(entityName: "Airport")
        fetchRequest.predicate = NSPredicate(format: "iata", iata)
        let result = try? managedObjectContext.fetch(fetchRequest)
        if let result = result, !result.isEmpty { return true }
        return false
    }
    
    func fetchAirports() -> Single<[AirportModel]> {
        let managedContext = managedObjectContext
        return Single.create { promise in
            let fetchRequest = NSAsynchronousFetchRequest(fetchRequest: Airport.fetchRequest()) { result in
                let airports = result.finalResult
                if let airports = airports {
                    let models = airports.map({ AirportModel(icao: $0.icao, iata: $0.iata, name: $0.name, municipalityName: nil, latitude: $0.latitude, longitude: $0.longitude)})
                    promise(.success(models))
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
