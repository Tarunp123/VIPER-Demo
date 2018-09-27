//
//  UsersView.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 9/26/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class UsersView: UIViewController {

    var presenter: UsersPresenterProtocol?
    
    private var usersTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }


    
    
}



extension UsersView : UsersViewProtocol{
    
    func setupView(){
        
        self.navigationItem.title = "Users"
        self.title = "Users"
        self.view.backgroundColor = UIColor.red
        
        self.usersTableView = UITableView()
        self.usersTableView.backgroundColor = UIColor.groupTableViewBackground
        self.usersTableView.dataSource = self
        self.usersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        self.view.addSubview(self.usersTableView!)
        self.usersTableView.translatesAutoresizingMaskIntoConstraints = false
        self.usersTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.usersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.usersTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.usersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    
    func updateView() {
        
    }
    
    
}



extension UsersView : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        cell.textLabel?.text = "Index \(indexPath.row)"
        return cell
    }
    
}



