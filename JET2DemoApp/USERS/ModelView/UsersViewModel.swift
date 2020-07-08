//
//  UsersViewModel.swift
//  JET2DemoApp
//
//  Created by Sachin on 05/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
import CoreData

class UsersViewModel {
    var currentPageRef = 1
    var updateLoadingStatus: ((Bool) -> ())?
    var didFinishFetch: ((Error?) -> ())?
}

extension UsersViewModel {
    func fetchFromServer() {
        if let updateHandler = self.updateLoadingStatus, currentPageRef == 1 {
            updateHandler(true)
        }
        ServiceRouter.shared.requestFetchUsers(with: currentPageRef, And: self) { (error) in
            if let updateHandler = self.updateLoadingStatus {
                updateHandler(false)
            }
            if let finishHandler = self.didFinishFetch {
                if let respError = error {
                    finishHandler(respError)
                }
                else {
                    finishHandler(nil)
                    self.currentPageRef += 1
                }
            }
            
        }
    }
    
    func parse(_ jsonData: Data) -> Error?  {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // Parse JSON data
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            _ = try decoder.decode([UsersModel].self, from: jsonData)
            
            try managedObjectContext.save()
            return nil
        } catch let error {
            print(error)
            return error
        }
    }
    
    func fetchFromStorage() -> [UsersModel]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<UsersModel>(entityName: "UsersModel")
        fetchRequest.returnsDistinctResults = true
//        let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor1]
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users
        } catch let error {
            print(error)
            return nil
        }
    }
}
