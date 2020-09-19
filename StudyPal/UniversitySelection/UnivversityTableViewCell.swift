//
//  UnivversityTableViewCell.swift
//  StudyPal
//
//  Created by John Demirci on 9/19/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class UnivversityTableViewCell: UITableViewCell {

    static let identifier = "uniCellId"
    
    
    private let myLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = goldColor
        label.text = "custom cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public func configure(text: String) {
        myLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = appColor
        contentView.addSubview(myLabel)
        myLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        myLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
