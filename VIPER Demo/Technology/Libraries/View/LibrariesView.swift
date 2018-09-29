//
//  LibrariesView.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class LibrariesView: UIViewController {

    var presenter: LibrariesPresenterProtocol?
    
    private var librariesTableView : UITableView!
    private var cellId = "LibrariesCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter?.viewDidLoad()
    }


    

}

extension LibrariesView : LibrariesViewProtocol{
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        self.librariesTableView = UITableView(frame: .zero, style: .grouped)
        self.librariesTableView.backgroundColor = UIColor.groupTableViewBackground
        self.librariesTableView.dataSource = self
        self.librariesTableView.allowsSelection = false
        self.librariesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(self.librariesTableView)
        self.librariesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.librariesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.librariesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.librariesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.librariesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
}


extension LibrariesView : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.presenter?.titleForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        if let item = self.presenter?.itemAtIndex(index: indexPath.row, inSection: indexPath.section){
            cell.textLabel?.text = item
        }
        return cell
    }
    
}

