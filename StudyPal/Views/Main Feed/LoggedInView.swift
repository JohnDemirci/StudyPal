//
//  LoggedInView.swift
//  StudyPal
//
//  Created by John Demirci on 9/23/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class LoggedInView: UIViewController {
    
    var user = User()
    
    let profile_image : UIImageView = {
        let image = UIImageView(image: UIImage(named: "empty_profile_picture"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 80).isActive = true
        image.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return image
    }()
    
    
    lazy var create_post_popup : UIView = {
        let viewx = UIView()
        viewx.backgroundColor = goldColor.withAlphaComponent(0.5)
        viewx.layer.cornerRadius = 20
        viewx.layer.shadowColor = UIColor.green.cgColor
        viewx.layer.shadowRadius = 20
        viewx.translatesAutoresizingMaskIntoConstraints = false
        return viewx
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
        barButtons()
        
        view.addSubview(profile_image)
        profile_image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profile_image.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        
    }
}
