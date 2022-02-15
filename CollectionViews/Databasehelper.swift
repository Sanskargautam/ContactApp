//
//  Databasehelper.swift
//  CollectionViews
//
//  Created by Sanskar on 10/02/22.
//  Copyright © 2022 Macco. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper
{
    static var databaseObj = DatabaseHelper()
    private init()
    {}
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func save(userObj : UserData)
    {
        let user = NSEntityDescription.insertNewObject(forEntityName: "UserContext", into: context!) as! UserContext
        
        user.firstName = userObj.firstName
        user.lastName = userObj.lastName
        user.phone = userObj.phone
        user.email = userObj.email
        user.address = userObj.address
        do
        {
            try context?.save()
        }
        catch
        {
            print("Data not saved")
        }
    }
    
    func getUser()
    {
        var User = [UserContext]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserContext")
        do{
            User = try context?.fetch(fetchRequest) as! [UserContext]
        }
        catch
        {
            print("Data not got")
        }
        for pUser in User
        {
            let obj = UserData.init(pUser.firstName!, pUser.lastName!, pUser.phone!, pUser.email!, pUser.address!)
            users.append(obj)
        }
    }
    
    func deleterUser(index : Int)
    {
        var user = [UserContext]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserContext")
        do{
            user = try context?.fetch(fetchRequest) as! [UserContext]
        }
        catch
        {
            print("Data not got")
        }
        context?.delete(user[index])
        user.remove(at: index)
        do{
            try context?.save()
        }
        catch
        {
            print("can not delete")
        }
    }

    func editUser(userObj : UserData , index : Int)
    {
        var user = [UserContext]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserContext")
        do{
            user = try context?.fetch(fetchRequest) as! [UserContext]
        }
        catch
        {
            print("Data not got")
        }
        user[index].firstName = userObj.firstName
        user[index].lastName = userObj.lastName
        user[index].phone = userObj.phone
        user[index].email = userObj.email
        user[index].address = userObj.address

        do
        {
            try context?.save()
        }
        catch
        {
            print("Data not saved")
        }
    }
}
