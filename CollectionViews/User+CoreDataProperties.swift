//
//  User+CoreDataProperties.swift
//  CollectionViews
//
//  Created by Sanskar on 10/02/22.
//  Copyright © 2022 Macco. All rights reserved.
//
//

import Foundation
import CoreData


extension UserContext {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContext> {
        return NSFetchRequest<UserContext>(entityName: "UserContext")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?

}

extension UserContext : Identifiable {

}
