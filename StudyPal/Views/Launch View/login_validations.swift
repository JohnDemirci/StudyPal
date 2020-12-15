//
//  login_validations.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import Foundation

extension HomeView {
    func validated () -> Bool {
        do {
            try username_password_validations()
            return true
        }
        catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    
    
    func username_password_validations () throws {
        if homeUsername.text == "" || homeUsername.text == nil {
            throw LoginError.noUsernameEntered
        }
        if homePassword.text == "" || homePassword.text == nil {
            throw LoginError.noPasswordEntered
        }
    }
}
