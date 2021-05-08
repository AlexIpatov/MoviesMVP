//
//  CoreDataFilm+CoreDataProperties.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//
//

import Foundation
import CoreData

extension CoreDataFilm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataFilm> {
        return NSFetchRequest<CoreDataFilm>(entityName: "CoreDataFilm")
    }

    @NSManaged public var nameRu: String?
    @NSManaged public var year: String?
    @NSManaged public var rating: String?
    @NSManaged public var filmID: Int16
    @NSManaged public var posterURL: String?

}

extension CoreDataFilm : Identifiable {

}
