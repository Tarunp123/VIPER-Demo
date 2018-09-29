//
//  LibrariesPresenter.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 29/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation

class LibrariesPresenter:  LibrariesPresenterProtocol{
    
    var view: LibrariesViewProtocol?
    var router: LibrariesRouterProtocol?
    
    
    private var sectionTitles = ["Architecture Used", "Standard Libraries Used", "External Libraries Used", "Tools Used"]
    private var items = [["VIPER"], ["Foundation", "UIKit"], ["Moya", "Moa"], ["Xcode",  "Git", "Sketch",]]
    
    func viewDidLoad() {
        self.view?.setupView()
    }
    
    func numberOfSections() -> Int {
        return self.sectionTitles.count
    }
    
    func titleForSection(section: Int) -> String {
        guard section < self.sectionTitles.count else{
            return "INVALID SECTION"
        }
        return sectionTitles[section]
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        guard section < self.items.count else{
            return 0
        }
        return self.items[section].count
    }
    
    func itemAtIndex(index: Int, inSection section: Int) -> String {
        if section >= self.items.count && index >= self.items[section].count{
            return "Invalid Index and/or Section"
        }
        
        return self.items[section][index]
    }
    
    
}
