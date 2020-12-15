//
//  ErrorFile.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import Foundation


enum LoginError : Error {
    case noUsernameEntered
    case noPasswordEntered
    case invalidEntry
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noUsernameEntered:
            return NSLocalizedString("please enter a username", comment: "")
        case .noPasswordEntered:
            return NSLocalizedString("please enter a password", comment: "")
        case .invalidEntry:
            return NSLocalizedString("wrong information", comment: "")
        }
    }
}
