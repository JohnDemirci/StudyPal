//
//  LoggedInView.swift
//  StudyPal
//
//  Created by John Demirci on 9/23/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class LoggedInView: UIViewController {
    
    public var userId : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
        barButtons()
        print("\(userId!)")
        // Do any additional setup after loading the view.
    }
}


extension LoggedInView {
    func barButtons () {
        let add = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItems = [add]
    }
    
    @objc func addTapped() {
        self.present(CreatePost(), animated: true)
    }
}
