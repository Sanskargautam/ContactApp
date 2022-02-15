//
//  SecondViewController.swift
//  CollectionViews
//
//  Created by Sanskar on 07/02/22.
//  Copyright © 2022 Macco. All rights reserved.
//

import Foundation

import UIKit

class SecondViewController : UIViewController , DataPassing
{
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var UserLabel: UILabel?
    
    var userValue : UserData?
    var indexOfUser : IndexPath?
    
    var firstName : String?
    var lastName : String?
    var phone : String?
    var email : String?
    var address : String?
    
    func details(textFieldValue: String, index: Int)
    {
        if(index == 0)
        {
            self.firstName = textFieldValue
        }
        else if(index == 1)
        {
            self.lastName = textFieldValue
        }
        else if(index == 2)
        {
            self.phone = textFieldValue
        }
        else if(index == 3)
        {
            self.email = textFieldValue
        }
        else if(index == 4)
        {
            self.address = textFieldValue
        }
    }
    
    var flag = 0
    
    @objc func editclickButton()
    {
        if(flag == 0) //user wants to edit data
        {
            self.navigationItem.rightBarButtonItem?.title = "Save"
            flag = 2
            self.tableView?.reloadData()
        }
        else if(flag == 1 || flag == 2) // user is saving/editing data
        {
            var temp = true
            if(!Validator.validateString(firstName))
            {
                let alert = UIAlertController(title: "WARNING", message: "Input type First Name is invalid", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                temp = false
            }
            if(!Validator.validateString(lastName))
            {
                let alert = UIAlertController(title: "WARNING", message: "Input type Last Name is invalid", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                temp = false
            }
            if(!Validator.validateString(address))
            {
                let alert = UIAlertController(title: "WARNING", message: "Input type address is invalid", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                temp = false
            }
            if(!Validator.validatephone(phone))
            {
                let alert = UIAlertController(title: "WARNING", message: "Input type phone is invalid", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                temp = false
            }
            if(!Validator.validateEmail(email))
            {
                let alert = UIAlertController(title: "WARNING", message: "Input type email is invalid", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil ))
                self.present(alert, animated: true, completion: nil)
                temp = false
            }
            if(temp)
            {
                let obj = UserData(firstName!, lastName!, phone!, email!, address!)
                if (flag == 2)
                {
                    if let index = indexOfUser
                    {
                        CNContact.cnObj.deleteContact(phone: users[index.row].phone!)
                        users[index.row].firstName = firstName
                        users[index.row].lastName = lastName
                        users[index.row].phone = phone
                        users[index.row].email = email
                        users[index.row].address = address
                        DatabaseHelper.databaseObj.editUser(userObj: obj, index: index.row)
                        CNContact.cnObj.add(obj)
                        
                    }
                }
                else
                {
                    CNContact.cnObj.add(obj)
                    users.append(obj)
                    DatabaseHelper.databaseObj.save(userObj: obj)
                }
                
                if let navController = self.navigationController
                {
                    navController.popViewController(animated: true)
                    return
                }
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if(flag == 0 || flag == 2) // initialising global variable (user edit particular detail rest remain same)
        {
            self.firstName = userValue?.firstName
            self.lastName = userValue?.lastName
            self.phone = userValue?.phone
            self.email = userValue?.email
            self.address = userValue?.address
        }
        
        let testUIBarButtonItem = UIBarButtonItem(title: (flag == 1 ? "Save" : "Edit") , style: .plain , target: self
                                                  , action: #selector(self.editclickButton))
        self.navigationItem.rightBarButtonItem  = testUIBarButtonItem
        
        UserLabel?.layer.masksToBounds = true
        UserLabel?.layer.cornerRadius = 85
        
        if(flag == 0){
            if let fName = userValue?.firstName , let lName = userValue?.lastName
            {
                UserLabel?.text = (fName.prefix(upTo: fName.index(fName.startIndex, offsetBy: 1))).uppercased() + (lName.prefix(upTo: lName.index(lName.startIndex, offsetBy: 1))).uppercased()
            }
        }
        tableView?.dataSource = self
        tableView?.delegate = self
    }
}

extension SecondViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        
        cell.valueField.isUserInteractionEnabled = (flag == 1 || flag == 2 ? true : false )// enable-disable text field editing
        
        cell.delegate = self
        cell.index = indexPath
       
        
        if(flag == 1 || flag == 2) //user wants to edit data
        {
            cell.valueField.backgroundColor = .white
        }
        else // user want to see data
        {
            cell.valueField.backgroundColor = .lightGray
        }
        
        if(indexPath.row == 0)
        {
            cell.title.text = "First Name"
            if(flag == 0 || flag == 2){
            cell.valueField.text = userValue?.firstName
            }
        }
        else if(indexPath.row == 1)
        {
            cell.title.text = "Last Name"
            if(flag == 0 || flag == 2){
            cell.valueField.text = userValue?.lastName
            }
        }
        else if(indexPath.row == 2)
        {
            cell.title.text = "Contact"
            if(flag == 0 || flag == 2){
            cell.valueField.text = userValue?.phone
            }
        }
        else if(indexPath.row == 3)
        {
            cell.title.text = "Email"
            if(flag == 0 || flag == 2){
            cell.valueField.text = userValue?.email
            }
        }
        else if(indexPath.row == 4)
        {
            cell.title.text = "Address"
            if(flag == 0 || flag == 2){
            cell.valueField.text = userValue?.address
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(80)
    }
}
