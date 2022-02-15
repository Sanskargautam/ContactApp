//
//  MovieCollectionViewCell.swift
//  CollectionViews
//
// Created by Sanskar on 3/02/2022.



import UIKit

protocol DataDeleteProtocol
{
    func deleteData(index : Int)
}

class UserCollectionViewCell: UICollectionViewCell{
    
    var index : IndexPath?
    var delegate : DataDeleteProtocol?
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var labelValue: UILabel!
    
    @IBAction func deleteButton(_ sender: UIButton) {
        delegate?.deleteData(index: (index?.row)!)
    }
    
    func setup(with user: UserData) {
        if let fName = user.firstName , let lName = user.lastName
        {
            titleLbl.text = fName + " " + lName
            
            labelValue.layer.masksToBounds = true
            labelValue.layer.cornerRadius = 70
            
           labelValue.text = (fName.prefix(upTo: fName.index(fName.startIndex, offsetBy: 1))).uppercased() + (lName.prefix(upTo: lName.index(lName.startIndex, offsetBy: 1))).uppercased()
        }
    }
}

