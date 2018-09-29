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
    private let cellId = "UserCell"
    
    private var activityIndicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
  
}



extension UsersView : UsersViewProtocol{
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        self.usersTableView = UITableView(frame: .zero, style: .grouped)
        self.usersTableView.backgroundColor = UIColor.groupTableViewBackground
        self.usersTableView.dataSource = self
        self.usersTableView.delegate = self
        self.usersTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(self.usersTableView)
        self.usersTableView.translatesAutoresizingMaskIntoConstraints = false
        self.usersTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.usersTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.usersTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.usersTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }

    
    func updateView() {
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
        }
    }
    
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if let activityIndicator = self.activityIndicator{
                activityIndicator.startAnimating()
                return
            }
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            self.activityIndicator?.hidesWhenStopped = true
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicator!)
            self.activityIndicator?.startAnimating()
        }
    }
    
    
    func removeLoadingIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.activityIndicator{
                activityIndicator.stopAnimating()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    
    
}



extension UsersView : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfUsers() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let user = self.presenter?.userAtIndex(index: indexPath.row){
            cell.textLabel?.text = "User \(user.id)"
        }else{
            cell.textLabel?.text = "User X"
        }
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
}

extension UsersView : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.presenter?.didSelectUserAtIndex(index: indexPath.row)
    }
    
}


