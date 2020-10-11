//
//  User.swift
//  SupermarketListCoreData
//
//  Created by Fernando Mueller on 19/09/20.
//  Copyright © 2020 Fernando Mueller. All rights reserved.
//

import SwiftUI
import CoreData

struct User : Identifiable {
    var id : String
    var username : String
    var password : String
    var time : String
    var day : String
}



//User CRUD
class ObserverUser : ObservableObject {
    @Published var datas = [User]()
    
    //load DB data
    init() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
        
        
        //load data from database: Supermarket
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                let id = i.value(forKey: "id") as! String
                let username = i.value(forKey: "username") as! String
                let password = i.value(forKey: "password") as! String
                let time = i.value(forKey: "time") as! String
                let day = i.value(forKey: "day") as! String
                
                self.datas.append(User(id: id, username: username, password: password, time: time, day: day))
                
            }
        }
        catch {
            print(error.localizedDescription)
        }
        
    }
    
    //func add new product
    func  add(
        username: String,
        password: String,
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
        let entity = NSEntityDescription.insertNewObject(forEntityName: "UserTable", into: context)
        entity.setValue("\(date.timeIntervalSince1970)", forKey: "id")
        entity.setValue(username, forKey: "username")
        entity.setValue(password, forKey: "password")
        entity.setValue(time, forKey: "time")
        entity.setValue(day, forKey: "day")
        
        //Save
        do {
            try context.save()
            self.datas.append(User(id: "\(date.timeIntervalSince1970)", username: username, password: password, time: time, day: day))
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //func login
    func login(username: String, password: String) -> Bool {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
        
        //load data from database: Supermarket
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                //print("i \(i) res \(res)")
                //load by username / password
                if i.value(forKey: "username") as! String == username && i.value(forKey: "password") as! String == password {
                    try context.save()

                    print("login executado com sucesso")
                    return true
                    
                }
                else {
                    print("login não executado com sucesso ")
                    //return false
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    
    //func delete a product
    func delete(id: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
        
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
    func update(username: String, password: String) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        //database request: Supermarket
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "UserTable")
        
        //load data from database: Supermarket
        do {
            let res = try context.fetch(req)
            
            for i in res as! [NSManagedObject] {
                //update
                //if i.value(forKey: "id") as! String == id {
                if i.value(forKey: "username") as! String == username {
                    //i.setValue(username, forKey: "username")
                    i.setValue(password, forKey: "password")
                    
                    try context.save()
                    for i in 0..<datas.count {
                        if datas[i].username == username {
                            //datas[i].username = username
                            datas[i].password = password
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
