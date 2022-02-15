//
//  CNContact.swift
//  CollectionViews
//
//  Created by Sanskar on 14/02/22.
//  Copyright © 2022 Macco. All rights reserved.
//


import Foundation
import Contacts
class CNContact{
    
    static let cnObj = CNContact()
    private init(){}
    
    let store = CNContactStore()
    
    func fetchContacts(){
        print("Attempting to fetch contacts today")
        
        store.requestAccess(for: .contacts) { [self] granted, err in
            if let err = err{
                print("Failed to request access",err)
                return
            }
            
            let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactPostalAddressesKey]
            
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            do{
                try self.store.enumerateContacts(with: request, usingBlock: {
                    (contact, stopEnumerating) in
                     
                    let temp = UserData(contact.givenName, contact.familyName, contact.phoneNumbers.first?.value.stringValue ?? " ", (contact.emailAddresses.first?.value ?? " ") as String, " ")
                    //contact.emailAddresses.map { $0.value as String }
                    
                    DatabaseHelper.databaseObj.save(userObj: temp)
                    users.append(temp)
                    
                })
            }
            catch{
                
            }
            if granted
            {
                print("Access granted to fetch")
            }
        }
    }
    
    func deleteContact(phone:String){
        store.requestAccess(for: .contacts) { [self] granted, err in
            if let err = err{
                print("Failed to request access to delete",err)
                return
            }
            
            let keys = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey,CNContactPostalAddressesKey]
            
            let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
            
            do{
                try self.store.enumerateContacts(with: request, usingBlock: {
                    (contact, stopEnumerating) in
          
                    if(phone == contact.phoneNumbers.first?.value.stringValue ?? " "){
                    let req = CNSaveRequest()
                    let mutable = contact.mutableCopy() as! CNMutableContact
                    req.delete(mutable)
                        do{
                            try store.execute(req)
                        }
                        catch let e{
                            print(e)
                        }
                    
                    }
                    
                })
            }
            catch{
                
            }
            
            if granted{
                print("Access granted for delete")
            }
        }
    }
    
    func add(_ obj : UserData){
        let con = CNMutableContact()
        con.givenName = obj.firstName!
        con.familyName = obj.lastName!
        con.phoneNumbers.append(CNLabeledValue(label: "PhoneNumber", value: CNPhoneNumber(stringValue: obj.phone!)))
        let workEmail = CNLabeledValue(label:"Work Email", value:(obj.email ?? "") as NSString)
        con.emailAddresses = [workEmail]
        
   
        let req = CNSaveRequest()
        req.add(con, toContainerWithIdentifier: nil)
        do{
        try store.execute(req)
        }
        catch let err{
            print(err ,"couldn't save it")
        }
    }
    
    
    
}
