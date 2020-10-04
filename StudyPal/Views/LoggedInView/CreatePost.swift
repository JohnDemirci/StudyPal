//
//  CreatePost.swift
//  StudyPal
//
//  Created by John Demirci on 10/3/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

class CreatePost: UIViewController {
    
    let className = UITextField()
    let subjectName = UITextField()
    let studyType = UITextField()
    let startDate = UIDatePicker()
    let enableDepartment = UIButton()
    let submit = UIButton()
    let cancel = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
    }
}
