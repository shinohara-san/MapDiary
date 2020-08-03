//
//  CustomTableViewCell.swift
//  MapDiary
//
//  Created by Yuki Shinohara on 2020/08/02.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    
    let locationLabel = UILabel()
    let dateLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        locationLabel.text = "場所の名前"
        dateLabel.text = "日時"
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(locationLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let screenWidth:CGFloat = contentView.frame.size.width
//        let screenHeight:CGFloat = contentView.frame.size.height
//        locationLabel.frame = CGRect(x: 10,y: 0,width: screenWidth, height: screenHeight)
//        dateLabel.frame = CGRect(x: 10, y: 35, width: screenWidth, height: screenHeight)
        
        locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor).isActive = true
        dateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
