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
}

extension CoreDataFilm : Identifiable {

}
