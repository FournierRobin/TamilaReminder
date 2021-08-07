//
//  Profile+CoreDataProperties.swift
//  TsRv3
//
//  Created by Robin Fournier on 22/05/2021.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var username: String?

}

extension Profile : Identifiable {

}
