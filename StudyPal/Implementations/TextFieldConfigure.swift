//
//  TextFieldConfigure.swift
//  StudyPal
//
//  Created by John Demirci on 10/28/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import Foundation
import UIKit

// Implementation of the texfields design
// the function takes textfield and placeholder
func textfieldConfiguration (txtField: UITextField,
                             placeholder: String,
                             secureField: Bool,
                             text_color: UIColor,
                             border_color: UIColor) -> UITextField {
    txtField.autocapitalizationType = .none
    txtField.autocorrectionType = .no
    if secureField /* then */ { txtField.isSecureTextEntry = true }
    txtField.translatesAutoresizingMaskIntoConstraints = false
    txtField.backgroundColor = .clear
    // the goldColor is implemented in HexColorImplementation.swift file
    txtField.layer.borderColor = border_color.cgColor
    // this will give us a Rounded Rectangle
    txtField.layer.cornerRadius = 12
    txtField.textColor = text_color
    // setting the clipYoBounds true so it will not go over the borders
    // we have a clear background so this may not be necessary
    // however when it comes to password entry the background may chhange to a yellow color which then it goes over the border
    txtField.clipsToBounds = true
    txtField.widthAnchor.constraint(equalToConstant: 300).isActive = true
    txtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    txtField.layer.borderWidth = 1
    txtField.textAlignment = .center
    // changing the placeholder color to goldColor
    txtField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: text_color])
    return txtField
}
