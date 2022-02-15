//
//  ViewController.swift
//  CollectionViews

// Created by Sanskar on 3/02/2022.


import UIKit

class ViewController: UIViewController, UISearchBarDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBAction func AddContactButton(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.flag = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var filterData : [UserData] = []
    
    override func viewWillAppear(_ animated: Bool)
    {
        filterData = users
        
        filterData = filterData.sorted(by: {
            $0.firstName! < $1.firstName!
        })
        
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad()
    {
        users = users.sorted(by: {
            $0.firstName! < $1.firstName!
        })
        
        super.viewDidLoad()
        
        self.title = "Contacts"
        
        filterData = users
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        searchBar.delegate = self
    }
}

extension ViewController: UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return filterData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as! UserCollectionViewCell
        cell.setup(with: filterData[indexPath.row])
        cell.index = indexPath
        cell.delegate = self
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 200, height: 230)
    }
    
    //UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //print(filterData[indexPath.row].firstName!)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        vc.userValue = filterData[indexPath.row]
        vc.indexOfUser = indexPath
        vc.flag = 0
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        filterData = []
        
        if searchText == ""
        {
            filterData = users
        }
        for pUser in users
        {
            
            if let name = pUser.firstName{
                if name.uppercased().contains(searchText.uppercased())
                {
                    filterData.append(pUser)
                }
            }
        }
        self.collectionView.reloadData()
    }
}

extension ViewController: DataDeleteProtocol
{
    func deleteData(index: Int)
    {
        let alert = UIAlertController(title: "ALERT", message: "The contact will get permanently deleted", preferredStyle: UIAlertController.Style.alert)

        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { action in
                CNContact.cnObj.deleteContact(phone: users[index].phone!)
                let userContact = self.filterData[index].phone
                self.filterData.remove(at: index)
                for index in stride(from: 0 , to: users.count, by: 1)
                {
                    if (users[index].phone == userContact)
                    {
                        users.remove(at: index)
                        break
                    }
                }
                DatabaseHelper.databaseObj.deleterUser(index: index)
                self.collectionView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil ))

        // show the alert
        self.present(alert, animated: true, completion: nil)

    }
}

