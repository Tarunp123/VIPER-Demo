//
//  MessageCell.swift
//  VIPER Demo
//
//  Created by Tarun Prajapati on 28/09/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    static let padding : CGFloat = 8.0
    static let titleFont = UIFont.preferredFont(forTextStyle: .body).withSize(UIFont.preferredFont(forTextStyle: .body).pointSize)
    static let bodyFont = UIFont.preferredFont(forTextStyle: .caption1).withSize(UIFont.preferredFont(forTextStyle: .caption1).pointSize)
    
    private var titleLabel : UILabel?
    private var bodyLabel : UILabel?
    
    func setupCellForMessage(message: Message, inExpandedMode expandedMode: Bool) {
        self.titleLabel?.removeFromSuperview()
        
        self.titleLabel = UILabel()
        self.titleLabel?.font = MessageCell.titleFont
        self.titleLabel?.text = message.title
        self.titleLabel?.textColor = .black
        self.addSubview(self.titleLabel!)
        self.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel?.topAnchor.constraint(equalTo: self.topAnchor, constant: MessageCell.padding).isActive = true
        self.titleLabel?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MessageCell.padding).isActive = true
        self.titleLabel?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MessageCell.padding).isActive = true
        if expandedMode{
            self.titleLabel?.numberOfLines = 0
            let requiredHeight = UILabel.getSizeToFitText(text: message.title, font: self.titleLabel!.font!, fontPointSize: self.titleLabel!.font!.pointSize, maxWidth: self.contentView.frame.width - MessageCell.padding*2, maxHeight: nil).height
            self.titleLabel?.heightAnchor.constraint(equalToConstant: requiredHeight).isActive = true
        }else{
            self.titleLabel?.numberOfLines = 1
            self.titleLabel?.heightAnchor.constraint(equalToConstant: UILabel.heightForSingleLine(font: self.titleLabel!.font, fontPointSize: self.titleLabel!.font.pointSize)).isActive = true
        }
        
        
        self.bodyLabel?.removeFromSuperview()
        
        self.bodyLabel = UILabel()
        self.bodyLabel?.font = MessageCell.bodyFont
        self.bodyLabel?.text = message.body
        self.contentView.addSubview(self.bodyLabel!)
        self.bodyLabel?.translatesAutoresizingMaskIntoConstraints = false
        self.bodyLabel?.topAnchor.constraint(equalTo: self.titleLabel!.bottomAnchor, constant: MessageCell.padding).isActive = true
        self.bodyLabel?.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: MessageCell.padding).isActive = true
        self.bodyLabel?.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -MessageCell.padding).isActive = true
        if expandedMode{
            self.bodyLabel?.numberOfLines = 0
            let requiredHeight = UILabel.getSizeToFitText(text: message.body, font: self.bodyLabel!.font!, fontPointSize: self.bodyLabel!.font!.pointSize, maxWidth: self.contentView.frame.width - MessageCell.padding*2, maxHeight: nil).height
            self.bodyLabel?.heightAnchor.constraint(equalToConstant: requiredHeight).isActive = true
        }else{
            self.bodyLabel?.numberOfLines = 1
            self.bodyLabel?.heightAnchor.constraint(equalToConstant: UILabel.heightForSingleLine(font: self.bodyLabel!.font, fontPointSize: self.bodyLabel!.font.pointSize)).isActive = true
        }
        
        
        self.contentView.clipsToBounds = true
    }
    
    
    static func getCellHeightForMessage(message: Message, withCellWidth width: CGFloat, inExpandedMode expandedMode: Bool) -> CGFloat{
        if expandedMode{
            let titleHeight = UILabel.getSizeToFitText(text: message.title, font: MessageCell.titleFont, fontPointSize: MessageCell.titleFont.pointSize, maxWidth: width - MessageCell.padding*2, maxHeight: nil).height
            let bodyHeight = UILabel.getSizeToFitText(text: message.body, font: MessageCell.bodyFont, fontPointSize: MessageCell.bodyFont.pointSize, maxWidth: width - MessageCell.padding*2, maxHeight: nil).height
            return titleHeight + bodyHeight + padding*3
        }else{
            let titleHeight = UILabel.heightForSingleLine(font: MessageCell.titleFont, fontPointSize: MessageCell.titleFont.pointSize)
            let bodyHeight = UILabel.heightForSingleLine(font: MessageCell.bodyFont, fontPointSize: MessageCell.bodyFont.pointSize)
            return titleHeight + bodyHeight + padding*3
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }

}
