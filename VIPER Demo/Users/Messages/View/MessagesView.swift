//
//  MessagesView.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 27/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class MessagesView: UIViewController {

    var presenter: MessagesPresenterProtocol?
    
    private var messagesTableView : UITableView!
    private var cellId = "MessageCell"
    private var selectedMessageIndex = -1;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
   

}


extension MessagesView : MessagesViewProtocol{
    
    func setupView() {
        self.view.backgroundColor = UIColor.white
        
        self.messagesTableView = UITableView(frame: .zero, style: .grouped)
        self.messagesTableView.backgroundColor = UIColor.groupTableViewBackground
        self.messagesTableView.dataSource = self
        self.messagesTableView.delegate = self
        self.messagesTableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(self.messagesTableView)
        self.messagesTableView.translatesAutoresizingMaskIntoConstraints = false
        self.messagesTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.messagesTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.messagesTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.messagesTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }

    func expandCellAtIndex(index: Int) {
        DispatchQueue.main.async {
            self.messagesTableView.beginUpdates()
            if index == self.selectedMessageIndex{
                self.selectedMessageIndex = -1
                self.messagesTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
            }else{
                self.messagesTableView.reloadRows(at: [IndexPath(row: self.selectedMessageIndex, section: 0), IndexPath(row: index, section: 0)], with: UITableViewRowAnimation.automatic)
                self.selectedMessageIndex = index
            }
            self.messagesTableView.endUpdates()
        }
    }

}


extension MessagesView : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberOfMessages() ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == self.selectedMessageIndex{
            
            if let message = self.presenter?.messageAtIndex(index: indexPath.row){
               
                //checking if heights were previously calculated and stored earlier
                if let titleHeight = message.titleHeight, let bodyHeight = message.bodyHeight{
                    //already calculated
                    return CGFloat(titleHeight + bodyHeight) + MessageCell.padding*3
                }else{
                    //need to calculate
                    message.titleHeight = Float(UILabel.getSizeToFitText(text: message.title, font: MessageCell.titleFont, fontPointSize: MessageCell.titleFont.pointSize, maxWidth: tableView.frame.width - MessageCell.padding*2, maxHeight: nil).height)
                    
                    message.bodyHeight = Float(UILabel.getSizeToFitText(text: message.body, font: MessageCell.bodyFont, fontPointSize: MessageCell.bodyFont.pointSize, maxWidth: tableView.frame.width - MessageCell.padding*2, maxHeight: nil).height)
                    
                    return CGFloat(message.titleHeight! + message.bodyHeight!) + MessageCell.padding*3
                }
            }else{
                //Could not find message
                return 0
            }
            
        }else{
            
            ////checking if heights were previously calculated and stored
            if let titleHeight = MessageCell.titleLabelHeightInCollapsedMode, let bodyHeight = MessageCell.bodyLabelHeightInCollapsedMode{
                return titleHeight + bodyHeight + MessageCell.padding*3
            }
            
            //Need to calculate heights
            if MessageCell.titleLabelHeightInCollapsedMode == nil{
                MessageCell.titleLabelHeightInCollapsedMode = UILabel.heightForSingleLine(font: MessageCell.titleFont, fontPointSize: MessageCell.titleFont.pointSize)
                
            }
            if MessageCell.bodyLabelHeightInCollapsedMode == nil{
                MessageCell.bodyLabelHeightInCollapsedMode = UILabel.heightForSingleLine(font: MessageCell.bodyFont, fontPointSize: MessageCell.bodyFont.pointSize)
            }
            return MessageCell.titleLabelHeightInCollapsedMode! + MessageCell.bodyLabelHeightInCollapsedMode! + MessageCell.padding*3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessageCell
        if let message = self.presenter?.messageAtIndex(index: indexPath.row){
            cell.setupCellForMessage(message: message, inExpandedMode: (selectedMessageIndex == indexPath.row ? true : false))
        }
        return cell
    }
}


extension MessagesView : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectMessageAtIndex(index: indexPath.row)
    }
}
