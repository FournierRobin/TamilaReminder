//
//  Task+CoreDataProperties.swift
//  TsRv3
//
//  Created by Robin Fournier on 22/05/2021.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var category: Int64
    @NSManaged public var date: Date?
    @NSManaged public var descript: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isComplex: Bool
    @NSManaged public var isDone: Bool
    @NSManaged public var isImportant: Bool
    @NSManaged public var title: String?

}

extension Task : Identifiable {

}
