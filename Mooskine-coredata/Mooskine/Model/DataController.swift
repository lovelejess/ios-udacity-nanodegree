//
//  DataController.swift
//  Mooskine
//
//  Created by Jess Le on 4/13/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext!

    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            self.autoSaveContext()
            self.configureContexts()
            completion?()
        }
    }
    
    func configureContexts() {
        backgroundContext = persistentContainer.newBackgroundContext()

        viewContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true // background thread to take precedence
        
        backgroundContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // prefer its values over the persistence store
        viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump // prefer persistence store values over its property values
    }
}

extension DataController {
    
    func saveContext() {
        try? viewContext.save()
    }
    
    /**
            AutoSaves the context
     */
    func autoSaveContext(interval: TimeInterval = 30) {
        guard interval > 0 else {
            print("Cannot set negative autosave interval")
            return
        }
        
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            self.autoSaveContext()
            }
    }
}
