//
//  NewTaskConfig.swift
//  CoreDataTestDevLibre
//
//  Created by Robin Fournier on 21/05/2021.
//

import Foundation

struct NewTaskConfig {
    var updateItem : Task!
    
    var title: String = ""
    var date: Date = Date()
    var descript: String = ""
    var isDone: Bool = false
    var isImportant: Bool = false
    var isComplex: Bool = false
    var category: Int = 0
    var id = UUID().uuidString

    
   func gettingDone(task: Task) {
        task.isDone = true
    }
}
    
