//
//  LVStackView.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import Foundation


extension HomeView {
    // after scroll view is called then we add a stackView
    // this will cover the scrollView
    // we will insert our objects into this stack
    func stackViewConfiguration () {
        // basic configurations
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        homeStackView.axis = .vertical
        homeStackView.distribution = .fill
        homeStackView.alignment = .center
        homeStackView.spacing = 30

        
        
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
        buttonHStack.axis = .horizontal
        buttonHStack.distribution = .fillEqually
        buttonHStack.alignment = .center
        buttonHStack.spacing = 50
    }
}
