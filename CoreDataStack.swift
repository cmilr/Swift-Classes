//
//  CoreDataStack.swift
//  FieldManual
//
//  Created by Cary Miller on 10/20/17.
//  Copyright © 2017 C.Miller & Co. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
   
   // MARK: - Properties
   private let modelName: String
   lazy var managedContext: NSManagedObjectContext = {
      return self.storeContainer.viewContext
   }()
   
   // MARK: - Init
   init(modelName: String) {
      self.modelName = modelName
   }
   
   // MARK: - Core Data Stack
   private lazy var storeContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: self.modelName)
      container.loadPersistentStores { (storeDescription, error) in
         if let error = error as NSError? {
            print("Unresolved error \(error), \(error.userInfo)")
         }
      }
      return container
   }()
   
   func saveContext () {
      guard managedContext.hasChanges else { return }
      do {
         try managedContext.save()
      } catch let error as NSError {
         print("Unresolved error \(error), \(error.userInfo)")
      }
   }
   
   // MARK: - Core Data Ops
   func delete(_ object: NSManagedObject) {
      managedContext.delete(object)
      do {
         try managedContext.save()
      } catch let error as NSError {
         print("Error While Deleting \(object): \(error.userInfo)")
      }
   }
   
   func fetch(for entity: String) -> [NSManagedObject] {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
      var incomingArray: [NSManagedObject] = []
      
      do {
         incomingArray = (try managedContext.fetch(fetchRequest))
      } catch let error as NSError {
         print("Could not fetch. \(error), \(error.userInfo)")
      }
      
      return incomingArray
   }
   
   func fetchSorted(for entity: String, ascending: Bool) -> [NSManagedObject] {
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
      let sort = NSSortDescriptor(key: "sortingIndex", ascending: ascending)
      fetchRequest.sortDescriptors = [sort]
      var incomingArray: [NSManagedObject] = []
      do {
         incomingArray = (try managedContext.fetch(fetchRequest))
      } catch let error as NSError {
         print("Could not fetch. \(error), \(error.userInfo)")
      }
      return incomingArray
   }
   
   func syncSortingIndex(to array: [NSManagedObject]) {
      var index = 0
      for object in array {
         object.setValue(index, forKeyPath: "sortingIndex")
         index += 1
      }
   }
   
   func destroyAllRecords(for entity: String) {
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
      let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
      do {
         try managedContext.execute(batchDeleteRequest)
      } catch let error as NSError {
         print("Could not destroy records. \(error), \(error.userInfo)")
      }
   }
}
