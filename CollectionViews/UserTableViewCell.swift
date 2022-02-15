//
//  UserTableViewCell.swift
//  CollectionViews
//
//  Created by Sanskar on 11/02/22.
//  Copyright © 2022 Macco. All rights reserved.
//

import UIKit

protocol DataPassing
{
    func details(textFieldValue: String , index: Int)
}
class UserTableViewCell: UITableViewCell , UITextFieldDelegate {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var valueField: UITextField!
    
    var delegate : DataPassing?
    var index : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        valueField.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let textValue = textField.text , let indexUnwrapped = index{
        delegate?.details(textFieldValue: textValue , index: indexUnwrapped.row)
        }
    }
}
