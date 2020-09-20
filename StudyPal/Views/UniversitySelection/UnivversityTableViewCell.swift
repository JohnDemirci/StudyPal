//
//  UnivversityTableViewCell.swift
//  StudyPal
//
//  Created by John Demirci on 9/19/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class UnivversityTableViewCell: UITableViewCell {
    /*
     when it comes to the strings of cellIds it is quite easy to make mistakes
     we can use a static constant to have a better control over the cell id
     if we want to change this string later we will not have go all over out app chaning eveyr single one o the strings of this cell ID
     */
    static let identifier = "uniCellId"
    // our cells will consist of only one label
    // we can implement the label here
    private let myLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = goldColor
        label.text = "custom cell"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // we can configure the label text as a function call
    // whenever this function is called it will change the label textt
    public func configure(text: String) {
        myLabel.text = text
    }
    // this will free up space as well scroll in ut table view
    // and it will prepare those cells to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    /*
     *********************************************************************
     *********** INITILIZATION OF THE TABLE VIEW CELLS *******************
     *********************************************************************
     */
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // setting the colors here
        contentView.backgroundColor = appColor
        // adding the label to the cell
        contentView.addSubview(myLabel)
        myLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        myLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        myLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
