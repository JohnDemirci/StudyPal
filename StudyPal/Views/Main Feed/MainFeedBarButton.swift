//
//  MainFeedBarButton.swift
//  StudyPal
//
//  Created by John Demirci on 11/29/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit


// ADD USER POPUP VIEW
extension LoggedInView {
    func add_popup_to_view() {
        view.addSubview(create_post_popup)
        create_post_popup.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        create_post_popup.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        create_post_popup.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        create_post_popup.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
}



extension LoggedInView {
    func barButtons () {
        let add = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItems = [add]
    }
    
    @objc func addTapped() {
        study_session_configuration()
        add_popup_to_view()
    }
    
}


extension LoggedInView : UITextFieldDelegate {
    func study_session_configuration() {
        var cp_class = UITextField()
        var cp_subject = UITextField()
        SS_textfield_configuration(cp_class: &cp_class, cp_subject: &cp_subject)
        add_studySession_to_popup(cp_class: cp_class, cp_subject: cp_subject)
        var major1 = UIButton()
        var major2 = UIButton()
        var major3 = UIButton()
        
        configure_major_buttons(major1: &major1, major2: &major2, major3: &major3)
    }
    
    
    func SS_textfield_configuration(cp_class: inout UITextField, cp_subject: inout UITextField) {
        cp_class = textfieldConfiguration(txtField: cp_class, placeholder: "CLASS NAME", secureField: false, text_color: appColor, border_color: appColor)
        cp_subject = textfieldConfiguration(txtField: cp_subject, placeholder: "SUBJECT", secureField: false, text_color: appColor, border_color: appColor)
        cp_class.delegate = self
        cp_subject.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func add_studySession_to_popup(cp_class: UITextField, cp_subject: UITextField) {
        create_post_popup.addSubview(cp_class)
        cp_class.centerXAnchor.constraint(equalTo: create_post_popup.centerXAnchor).isActive = true
        cp_class.centerYAnchor.constraint(equalTo: create_post_popup.centerYAnchor).isActive = true
        cp_class.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        create_post_popup.addSubview(cp_subject)
        cp_subject.topAnchor.constraint(equalTo: cp_class.bottomAnchor, constant: 20).isActive = true
        cp_subject.centerXAnchor.constraint(equalTo: create_post_popup.centerXAnchor).isActive = true
        cp_subject.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}


extension LoggedInView {
    func configure_major_buttons(major1: inout UIButton, major2: inout UIButton, major3: inout UIButton) {
        major1.setTitle("DEPT 1", for: .normal)
        major2.setTitle("DEPT 2", for: .normal)
        major3.setTitle("DEPT 3", for: .normal)
    }
}

