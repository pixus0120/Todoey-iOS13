//
//  AppDelegate.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)

//        let data = Data()
//        data.name = "Angela"
//        data.age = 12

        do{
            let _ = try Realm()
//            try realm.write {
//                realm.add(data)
//            }
        } catch {
            print("error initializing new realm application, \(error)")
        }

        return true
    }
    
//    func applicationWillTerminate(_ application: UIApplication) {
//        self.saveContext()
//    }

    // MARK: - Core Data stack
//
//    lazy var persistentContainer: NSPersistentContainer = {   //sql
//
//        let container = NSPersistentContainer(name: "DataModel")    //same name 'match'
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//
//    // MARK: - Core Data Saving support
//
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
}

