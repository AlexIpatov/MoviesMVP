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
    @NSManaged var nameRu: String?
    @NSManaged var nameEn: String?
    @NSManaged var year: String?
    @NSManaged var rating: String?
    @NSManaged var filmID: Int32
    @NSManaged var posterURL: String?
    @NSManaged var posterURLPreview: String?
}
extension CoreDataFilm : Identifiable {

}
