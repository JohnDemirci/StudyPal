//
//  ViewController.swift
//  StudyPal
//
//  Created by John Demirci on 9/5/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class HomeView: UIViewController, UIScrollViewDelegate {
    
    // this blank view is going to be used to adjust the elements in the screen
    // it will work as a spacer
    var blankView : UIView = {
        let blank = UIView()
        blank.translatesAutoresizingMaskIntoConstraints = false
        blank.backgroundColor = .clear
        blank.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return blank
    }()
    var homeScrollView = UIScrollView()
    var homeStackView = UIStackView()
    var homeUsername = UITextField()
    var homePassword = UITextField()
    var rememberMeButton = UIButton()
    var homeRegister = UIButton()
    var homeLogin = UIButton()
    var buttonHStack = UIStackView()
    
    let logo : UIImageView = {
        let image = UIImageView(image: UIImage(named: "StudyPalLogo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 300).isActive = true
        image.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // appColor and goldColor are implemented in
        // ColorImplementation.swift file
        view.backgroundColor = appColor
        scrollViewConfiguration()
        stackViewConfiguration()
        addTextFields()
        addButtons()
        homeViewConstraints()
        // TODO:
        /*
         CHECK IF REMEMBER ME WAS SELECTEED
         IF IT WAS CHECK CORE DATA
         GRAB THE DATA AND LOGIN
         ELSE
         DO NOTHING
         */
    }

}


