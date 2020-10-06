//
//  CreatePost.swift
//  StudyPal
//
//  Created by John Demirci on 10/3/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class CreatePost: UIViewController {
    
    let scroll = UIScrollView()
    let stackView = UIStackView()
    let className = UITextField()
    let subjectName = UITextField()
    let studyType = UIButton()
    let startDate = UIDatePicker()
    let enableDepartment = UIButton()
    let submit = UIButton()
    let cancel = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
        scrollViewConfguration()
        stackViewConfguration()
        addTextFields()
        addConstraints()
    }
}
extension CreatePost: UIScrollViewDelegate {
    func scrollViewConfguration () {
        // allowing to customize the constraints
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bounces = true
        scroll.delegate = self
        // we are adding out scrollView into our main view
        view.addSubview(scroll)
        // down below we are saying that our scroll view should have the same dimensions as our view
        // except for the top side of our scroll view that should be 50 below of the topside of our main view
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true;
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true;
    }
    func stackViewConfguration () {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        // each element will have 50 spacing between them
        stackView.spacing = 50
        // after we added our scrollview we are adding a stack view that has the same dimensions
        scroll.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor).isActive = true;
        stackView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 100).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -10).isActive = true;
        // this width was necessary because in my tests i had a larger width than expected
        // it was scrolling horizantally
        // after adding this constraint it solved that problem
        stackView.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
    }
}

// *************** TEXT FIELD EXTENSION ************
/*
     > I am using extensions to make the code easier to navigate and to read
     > They provide simplicity
     > In this extension we are focusing on Textfields
*/
extension CreatePost : UITextFieldDelegate {
    func addTextFields () {
        textfieldConfiguration(txtField: className, placeholder: "Class Name")
        textfieldConfiguration(txtField: subjectName, placeholder: "Subject Name")
    }
    
    // Implementation of the texfields design
    // the function takes textfield and placeholder
    func textfieldConfiguration (txtField: UITextField, placeholder: String) {
        txtField.autocapitalizationType = .none
        txtField.autocorrectionType = .no
        txtField.delegate = self
        // setting translatesAutoresizingMaskIntoConstraints
        // to false allows us to use constrains
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.backgroundColor = .clear
        // setting the borders to a gold color
        // the goldColor is implemented in HexColorImplementation.swift file
        txtField.layer.borderColor = goldColor.cgColor
        // this will give us a Rounded Rectangle
        txtField.layer.cornerRadius = 20
        txtField.textColor = goldColor
        // setting the clipYoBounds true so it will not go over the borders
        // we have a clear background so this may not be necessary
        // however when it comes to password entry the background may chhange to a yellow color which then it goes over the border
        txtField.clipsToBounds = true
        txtField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        txtField.layer.borderWidth = 1
        txtField.textAlignment = .center
        txtField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // changing the placeholder color to goldColor
        txtField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: goldColor])
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



extension CreatePost {
    func addConstraints () {
        stackView.addArrangedSubview(className)
        stackView.addArrangedSubview(subjectName)
    }
}

