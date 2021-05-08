//
//  CoreDataService.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import Foundation
import CoreData

class CoreDataService {

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviesMVP")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context = persistentContainer.viewContext

    // MARK: - Core Data Saving support
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func saveFilmToCoreData(film: Film) {
        guard let newCoreDataFilm = NSEntityDescription.entity(forEntityName: "CoreDataFilm", in: context),
              let newCoreDataFilmObject = NSManagedObject(entity: newCoreDataFilm, insertInto: context) as? CoreDataFilm
        else { return }
        configCoreDataFilm(film: film, newCoreDataFilmObject: newCoreDataFilmObject)
        saveContext()

    }

    private func configCoreDataFilm(film: Film, newCoreDataFilmObject: CoreDataFilm) {
        newCoreDataFilmObject.filmID = Int16(film.filmID)
        newCoreDataFilmObject.rating = film.rating
        newCoreDataFilmObject.year = film.year
        newCoreDataFilmObject.nameRu = film.nameRu
    }
}
