//
//  Movie.swift
//  CollectionViews
//
// Created by Sanskar on 3/02/2022.
//

import UIKit

var users = [UserData]()

class UserData
{
    var firstName : String?
    var lastName : String?
    var phone : String?
    var email : String?
    var address : String?
    
    init(_ firstName: String , _ lastName: String , _ phone: String , _ email: String , _ address: String)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.email = email
        self.address = address
    }
}

