//
//  ArticlesViewModel.swift
//  JET2DemoApp
//
//  Created by Sachin on 06/07/20.
//  Copyright © 2020 Sachin. All rights reserved.
//

import UIKit
import CoreData

class ArticlesViewModel {
    var currentPageRef = 1

    var updateLoadingStatus: ((Bool) -> ())?
    var didFinishFetch: ((Error?) -> ())?
    
    func fetchArticles() {
        if let updateHandler = self.updateLoadingStatus, currentPageRef == 1 {
            updateHandler(true)
        }
        ServiceRouter.shared.requestFetchArticles(with: currentPageRef, And: self) { (error) in
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
}

extension ArticlesViewModel {
    func parse(_ jsonData: Data) -> Error? {
        do {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                fatalError("Failed to retrieve managed object context")
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            // Parse JSON data
            let managedObjectContext = appDelegate.persistentContainer.viewContext
            let decoder = JSONDecoder()
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            _ = try decoder.decode([ArticlesModel].self, from: jsonData)
            try managedObjectContext.save()
            return nil
        } catch let error {
            print(error)
            return error
        }
    }
    
    func fetchFromStorage() -> [ArticlesModel]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ArticlesModel>(entityName: "ArticlesModel")
//        let sortDescriptor1 = NSSortDescriptor(key: "id", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor1]
        do {
            let articles = try managedObjectContext.fetch(fetchRequest)
            return articles
        } catch let error {
            print(error)
            return nil
        }
    }
}

