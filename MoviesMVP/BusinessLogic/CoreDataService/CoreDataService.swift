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
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private lazy var context = persistentContainer.viewContext
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
    // MARK: - Save film to CoreData
    func saveFilmToCoreData(film: Film) {
        guard let newCoreDataFilm = NSEntityDescription.entity(forEntityName: "CoreDataFilm", in: context),
              let newCoreDataFilmObject = NSManagedObject(entity: newCoreDataFilm, insertInto: context) as? CoreDataFilm
        else { return }
        configCoreDataFilm(film: film, newCoreDataFilmObject: newCoreDataFilmObject)
        saveContext()
    }
    private func configCoreDataFilm(film: Film, newCoreDataFilmObject: CoreDataFilm) {
        newCoreDataFilmObject.filmID = Int32(film.filmID)
        newCoreDataFilmObject.rating = film.rating
        newCoreDataFilmObject.year = film.year
        newCoreDataFilmObject.nameRu = film.nameRu
        newCoreDataFilmObject.nameEn = film.nameEn
        newCoreDataFilmObject.posterURL = film.posterURL
        newCoreDataFilmObject.posterURLPreview = film.posterURLPreview
    }
    // MARK: - Load films from CoreData
    func loadFilmsFromCoreData (completion: @escaping ([Film]) -> Void) {
        var coreDataFilms = [CoreDataFilm]()
        let fetchRequest: NSFetchRequest<CoreDataFilm> = CoreDataFilm.fetchRequest()
        do {
            coreDataFilms = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        completion(configFilmsFromCoreData(coreDataFilms: coreDataFilms))
    }
    private func configFilmsFromCoreData(coreDataFilms: [CoreDataFilm]) -> [Film] {
        var films = [Film]()
        coreDataFilms.forEach { coreDataFilm in
            let film = Film(filmID: Int(coreDataFilm.filmID),
                            nameRu: coreDataFilm.nameRu ?? "",
                            nameEn: coreDataFilm.nameEn,
                            year: coreDataFilm.year,
                            rating: coreDataFilm.rating,
                            posterURL: coreDataFilm.posterURL ?? "",
                            posterURLPreview: coreDataFilm.posterURLPreview ?? "")
            films.append(film)
        }
        return films
    }
    // MARK: - Search filmID in CoreData
    func requestFilmFromCoreDataById(filmId: Int) -> CoreDataFilm? {
        let fetchRequest: NSFetchRequest<CoreDataFilm> = CoreDataFilm.fetchRequest()
        var coreDataFilm: CoreDataFilm?
        fetchRequest.predicate =  NSPredicate(format: "filmID = %@", "\(filmId)")
        do {
            coreDataFilm = try context.fetch(fetchRequest).first
        } catch {
            print(error.localizedDescription)
        }
        return coreDataFilm
    }
    func filmInCoreData (filmId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<CoreDataFilm> = CoreDataFilm.fetchRequest()
        var coreDataFilmCount: Int = 0
        fetchRequest.predicate =  NSPredicate(format: "filmID = %@", "\(filmId)")
        do {
            coreDataFilmCount = try context.fetch(fetchRequest).count
        } catch {
            print(error.localizedDescription)
        }
       return coreDataFilmCount != 0
    }
    // MARK: - Delete film from CoreData
    func removeFilm (film: Film) {
        let fetchRequest: NSFetchRequest<CoreDataFilm> = CoreDataFilm.fetchRequest()
        var coreDataFilm: CoreDataFilm?
        fetchRequest.predicate =  NSPredicate(format: "filmID = %@", "\(film.filmID)")
        do {
            coreDataFilm = try context.fetch(fetchRequest).first
        } catch {
            print(error.localizedDescription)
        }
        guard let coreDataFilm = coreDataFilm else { return }
        context.delete(coreDataFilm)
        saveContext()
}
    // MARK: - Delete all films from CoreData
    func removeAllFilmsFromCoreData() {
        do {
            try context.execute(NSBatchDeleteRequest(fetchRequest: NSFetchRequest(entityName: "CoreDataFilm")))
        } catch {
            print(error.localizedDescription)
        }
        saveContext()
    }
}
