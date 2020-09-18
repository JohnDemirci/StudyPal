//
//  buttonAnimations.swift
//  StudyPal
//
//  Created by John Demirci on 9/18/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import Foundation
import UIKit


func animateButtons (sender: UIButton) {
    sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: CGFloat(0.20), initialSpringVelocity: CGFloat(6.0), options: UIView.AnimationOptions.allowUserInteraction,
        animations: {
            sender.transform = CGAffineTransform.identity
        },
        completion: { Void in()  }
    )
}
