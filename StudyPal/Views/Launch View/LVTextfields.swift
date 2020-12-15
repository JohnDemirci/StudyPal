//
//  LVTextfields.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//


import UIKit



extension HomeView: UITextFieldDelegate {

    func addTextFields () {
        homeUsername = textfieldConfiguration(txtField: homeUsername, placeholder: "Username", secureField: false, text_color: goldColor, border_color: goldColor)
        homePassword = textfieldConfiguration(txtField: homePassword, placeholder: "Password", secureField: true, text_color: goldColor, border_color: goldColor)
        homeUsername.heightAnchor.constraint(equalToConstant: 50).isActive = true
        homePassword.heightAnchor.constraint(equalToConstant: 50).isActive = true
        homeUsername.delegate = self
        homePassword.delegate = self
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
}
