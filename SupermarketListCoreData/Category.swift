//
//  Category.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 10/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct Category : Identifiable {
    var id : String
    var name : String
    var time : String
    var day : String
}

//Product CRUD
class ObserverCategory : ObservableObject {
    @Published var datas = [Category]()
    
    //load DB data
    init() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Category
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCategory")
        
        
        //load data from database: Category
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                let id = i.value(forKey: "id") as! String
                let name = i.value(forKey: "name") as! String
                let time = i.value(forKey: "time") as! String
                let day = i.value(forKey: "day") as! String
                
                self.datas.append(Category(id: id, name: name, time: time, day: day))
                
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    //func add new category
    func  add(
        name: String,
        date: Date) {
        
        //formatted date
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YY"
        let day = format.string(from: date)
        format.dateFormat = "hh:mm a"
        let time = format.string(from: date)
        
        //Database
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: "ProductCategory", into: context)
        entity.setValue("\(date.timeIntervalSince1970)", forKey: "id")
        entity.setValue(name, forKey: "name")
        entity.setValue(time, forKey: "time")
        entity.setValue(day, forKey: "day")
        
        //Save
        do {
            try context.save()
            self.datas.append(Category(id: "\(date.timeIntervalSince1970)", name: name, time: time, day: day))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //func delete a product
    func delete(id: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Category
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCategory")
        
        
        //load data from database: Category
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                //delete by id
                if i.value(forKey: "id") as! String == id {
                    context.delete(i)
                    try context.save()
                    
                    for i in 0..<datas.count {
                        if datas[i].id == id {
                            datas.remove(at: i)
                            return
                        }
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //func update a product
    func update(id: String, name: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Category
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCategory")
        
        
        //load data from database: Category
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                //update
                if i.value(forKey: "id") as! String == id {
                    i.setValue(name, forKey: "name")
                    
                    try context.save()
                    for i in 0..<datas.count {
                        if datas[i].id == id {
                            datas[i].name = name
                            
                        }
                    }
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}


