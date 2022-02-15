//
//  Validator.swift
//  CollectionViews
//
//  Created by Sanskar on 14/02/22.
//  Copyright © 2022 Macco. All rights reserved.
//

import Foundation
import UIKit

class Validator : UIAlertAction
{
    static func validateString(_ name : String?) -> Bool
    {
        if let nameOp = name , nameOp.isEmpty == false
        {
            return true
        }
        return false
    }
    
    static func validatephone(_ phone : String?) -> Bool
    {
        if let phoneOp = phone , let _ = (Int)(phoneOp)
        {
            let phoneFCharacter = phoneOp.prefix(upTo: phoneOp.index(phoneOp.startIndex, offsetBy: 1))
            if(phoneOp.count == 10 && (phoneFCharacter == "9" || phoneFCharacter == "8" || phoneFCharacter == "7"))
            {
                return true
            }
        }
        return false
    }
    
    static func validateEmail(_ YourEMailAddress: String?) -> Bool {
        if let emailOp = YourEMailAddress{
        if emailOp == ""{
            return true
        }
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: emailOp)
        }
        return false
    }
}
