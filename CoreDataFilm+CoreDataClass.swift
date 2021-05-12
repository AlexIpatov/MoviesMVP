//
//  CoreDataFilm+CoreDataClass.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//
//

import Foundation
import CoreData

@objc(CoreDataFilm)
public class CoreDataFilm: NSManagedObject, Codable {

    @NSManaged var nameRu: String?
    @NSManaged var nameEn: String?
    @NSManaged var year: String?
    @NSManaged var rating: String?
    @NSManaged var filmID: Int32
    @NSManaged var posterURL: String?
    @NSManaged var posterURLPreview: String?

    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            do {
                try container.encode(filmID, forKey: .filmID)
            } catch {
                print("error")
            }
    }
     enum CodingKeys: String, CodingKey {
        case filmID = "filmId"
        case nameRu = "nameRu"
        case nameEn = "nameEn"
        case year = "year"
        case rating = "rating"
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let contextUserInfoKey = CodingUserInfoKey.context,
              let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "CoreDataFilm", in: managedObjectContext)
              else {
                  fatalError("decode failure")
        }
        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        do {
            self.nameRu = try container.decodeIfPresent(String.self, forKey: .nameRu)
            self.nameEn = try container.decodeIfPresent(String.self, forKey: .nameEn)
            self.year = try container.decodeIfPresent(String.self, forKey: .year)
            self.rating = try container.decodeIfPresent(String.self, forKey: .rating)
            self.filmID = try container.decodeIfPresent(Int32.self, forKey: .filmID) ?? 0
            self.posterURL = try container.decodeIfPresent(String.self, forKey: .posterURL)
            self.posterURLPreview = try container.decodeIfPresent(String.self, forKey: .posterURLPreview)
        } catch {
            print("error")
        }
    }
}


extension CodingUserInfoKey {
   static let context = CodingUserInfoKey(rawValue: "context")
}
