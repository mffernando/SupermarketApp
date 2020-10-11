//
//  Product.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 07/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct Product : Identifiable {
    var id : String
    var name : String
    var category : String
    var quantity : String
    var note : String
    var time : String
    var day : String
}

//Product CRUD
class ObserverProduct : ObservableObject {
    @Published var datas = [Product]()
    
    //load DB data
    init() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Supermarket")
        
        
        //load data from database: Supermarket
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                let id = i.value(forKey: "id") as! String
                let name = i.value(forKey: "name") as! String
                let category = i.value(forKey: "category") as! String
                let quantity = i.value(forKey: "quantity") as! String
                let note = i.value(forKey: "note") as! String
                let time = i.value(forKey: "time") as! String
                let day = i.value(forKey: "day") as! String
                
                self.datas.append(Product(id: id, name: name, category: category, quantity: quantity, note: note, time: time, day: day))
                
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    //func add new product
    func  add(
        name: String,
        category: String,
        quantity: String,
        note: String,
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
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Supermarket", into: context)
        entity.setValue("\(date.timeIntervalSince1970)", forKey: "id")
        entity.setValue(name, forKey: "name")
        entity.setValue(category, forKey: "category")
        entity.setValue(quantity, forKey: "quantity")
        entity.setValue(note, forKey: "note")
        entity.setValue(time, forKey: "time")
        entity.setValue(day, forKey: "day")
        
        //Save
        do {
            try context.save()
            self.datas.append(Product(id: "\(date.timeIntervalSince1970)", name: name, category: category, quantity: quantity, note: note, time: time, day: day))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //func delete a product
    func delete(id: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Supermarket")
        
        
        //load data from database: Supermarket
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
    func update(id: String, name: String, category: String, quantity: String, note: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Supermarket")
        
        
        //load data from database: Supermarket
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                //update
                if i.value(forKey: "id") as! String == id {
                    i.setValue(name, forKey: "name")
                    i.setValue(category, forKey: "category")
                    i.setValue(quantity, forKey: "quantity")
                    i.setValue(note, forKey: "note")
                    
                    
                    try context.save()
                    for i in 0..<datas.count {
                        if datas[i].id == id {
                            datas[i].name = name
                            datas[i].category = category
                            datas[i].quantity = quantity
                            datas[i].note = note
                            
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

