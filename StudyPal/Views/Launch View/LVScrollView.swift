//
//  LVScrollView.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit


extension HomeView {
    func scrollViewConfiguration () {
        homeScrollView.backgroundColor = .clear
        homeScrollView.translatesAutoresizingMaskIntoConstraints = false
        homeScrollView.delegate = self
        homeScrollView.bounces = true
        homeScrollView.indicatorStyle = .black
    }
}
