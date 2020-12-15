//
//  LVConstraints.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit


// ********* CONSTRAINT EXTENSION ***********
extension HomeView {
    // function to add stuff to the views
    func homeViewConstraints () {
        add_home_scroll_view()
        add_home_stack_view()
        add_logo_to_stack_view()
        add_emailTextfield_to_stack_view()
        add_passwordTextfield_to_stack_view()
        add_remember_button_to_stack_view()
        add_blank_view_to_stack_view()
        add_register_button_to_buttonStack()
        add_login_button_to_buttonStack()
        add_buttonStack_to_main_view()
    }
    
    private func add_home_scroll_view () {
        view.addSubview(homeScrollView)
        homeScrollView.frame = view.bounds
        let constraints = [homeScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                           homeScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                           homeScrollView.topAnchor.constraint(equalTo: view.topAnchor),
                           homeScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                           homeScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
                           homeScrollView.rightAnchor.constraint(equalTo: view.rightAnchor)]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func add_home_stack_view () {
        homeScrollView.addSubview(homeStackView)
        let constraints = [
            homeStackView.topAnchor.constraint(equalTo: homeScrollView.topAnchor),
            homeStackView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            homeStackView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            homeStackView.bottomAnchor.constraint(equalTo: homeScrollView.bottomAnchor),
            homeStackView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func add_logo_to_stack_view () {
        homeStackView.addArrangedSubview(logo)
    }
    
    private func add_emailTextfield_to_stack_view () {
        homeStackView.addArrangedSubview(homeUsername)
    }
    
    private func add_passwordTextfield_to_stack_view () {
        homeStackView.addArrangedSubview(homePassword)
    }
    
    private func add_remember_button_to_stack_view () {
        homeStackView.addArrangedSubview(rememberMeButton)
    }
    
    // adding a blank view here to add more space for the aestetics
    private func add_blank_view_to_stack_view () {
        homeStackView.addArrangedSubview(blankView)
    }
    
    private func add_register_button_to_buttonStack () {
        buttonHStack.addArrangedSubview(homeRegister)
    }
    
    private func add_login_button_to_buttonStack () {
        buttonHStack.addArrangedSubview(homeLogin)
    }
    
    private func add_buttonStack_to_main_view () {
        homeStackView.addArrangedSubview(buttonHStack)
    }
    
    
}
