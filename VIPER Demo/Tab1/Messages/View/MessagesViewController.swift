//
//  MessagesView.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class MessagesView: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupView() {
        self.navigationItem.title = "Messages"
        self.view.backgroundColor = UIColor.orange
    }

    
    
}
