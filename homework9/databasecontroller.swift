//
//  databasecontroller.swift
//  homework9
//
//  Created by ChenX on 20/11/2016.
//  Copyright © 2016 Evilsmile. All rights reserved.
//

import Foundation
import CoreData

class databasecontroller{
    
    private init(){
        
    }
    class func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    class func saveInLeg(string: String){
        let legislator = Legislators(context: databasecontroller.persistentContainer.viewContext)
        legislator.id = string
        databasecontroller.saveContext()
    }
    class func saveInBill(string: String){
        let bill = Bills (context: databasecontroller.persistentContainer.viewContext)
        bill.id = string
        databasecontroller.saveContext()
    }
    class func saveInCom(string: String){
        let com = Committees (context: databasecontroller.persistentContainer.viewContext)
        com.id = string
        databasecontroller.saveContext()
    }
    

    class func searchInLeg(string: String)-> Int {
        let fetchRequest:NSFetchRequest<Legislators> = Legislators.fetchRequest()
        var num:Int = 0
        //fetchRequest.fetchLimit = 10
        //fetchRequest.fetchOffset = 0
        //let predicate = NSPredicate(format: "id = "+string , "")
        //fetchRequest.predicate = predicate
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            for result in searchResults as [Legislators]{
                if(result.id! == string){
                    num += 1
                }
            }
            return num
        }
        catch{
          return 0
        }
    }
    class func searchInBill(string: String)-> Int {
        let fetchRequest:NSFetchRequest<Bills> = Bills.fetchRequest()
        var num:Int = 0
        //fetchRequest.fetchLimit = 10
        //fetchRequest.fetchOffset = 0
        //let predicate = NSPredicate(format: "id = "+string , "")
        //fetchRequest.predicate = predicate
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            for result in searchResults as [Bills]{
                if(result.id! == string){
                    num += 1
                }
            }
            return num
        }
        catch{
            return 0
        }
    }
    class func searchInCom(string: String)-> Int {
        let fetchRequest:NSFetchRequest<Committees> = Committees.fetchRequest()
        var num:Int = 0
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            for result in searchResults as [Committees]{
                if(result.id! == string){
                    num += 1
                }
            }
            return num
        }
        catch{
            return 0
        }
    }
    
    class func deleteInLeg(string: String){
        let fetchRequest:NSFetchRequest<Legislators> = Legislators.fetchRequest()
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            //print("number of results:\(searchResults.count)")
            for result in searchResults as [Legislators]{
                if(result.id! == string){
                    databasecontroller.getContext().delete(result)
                }
            }
            try! databasecontroller.saveContext()
        }
        catch{
        }
    }
    class func deleteInBill(string: String){
        let fetchRequest:NSFetchRequest<Bills> = Bills.fetchRequest()
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            //print("number of results:\(searchResults.count)")
            for result in searchResults as [Bills]{
                if(result.id! == string){
                    databasecontroller.getContext().delete(result)
                }
            }
            try! databasecontroller.saveContext()
        }
        catch{
        }
    }
    class func deleteInCom(string: String){
        let fetchRequest:NSFetchRequest<Committees> = Committees.fetchRequest()
        do{
            let searchResults = try databasecontroller.getContext().fetch(fetchRequest)
            //print("number of results:\(searchResults.count)")
            for result in searchResults as [Committees]{
                if(result.id! == string){
                    databasecontroller.getContext().delete(result)
                }
            }
            try! databasecontroller.saveContext()
        }
        catch{
        }
    }


    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    class func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
   
}
