//
//  File.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

protocol LibrariesRouterProtocol {
    static func createLibrariesModule() -> UIViewController
}

protocol LibrariesViewProtocol {
    var presenter: LibrariesPresenterProtocol? {get set}
    
    func setupView()
}

protocol LibrariesPresenterProtocol {
    
    var view : LibrariesViewProtocol? {get set}
    var router : LibrariesRouterProtocol? {get set}
    
    func viewDidLoad()
    func numberOfSections() -> Int
    func titleForSection(section: Int) -> String
    func numberOfItemsInSection(section: Int) -> Int
    func itemAtIndex(index: Int, inSection section: Int) -> String
}
