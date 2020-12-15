//
//  UserModel.swift
//  StudyPal
//
//  Created by John Demirci on 9/23/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//


struct RegisteringUser {
    var uid: String
    var email: String
    var name: String
    var password: String
    var university: String
    var major: String
}


class User {
    private var uid: String?
    private var email: String?
    private var name: String?
    private var university: String?
    private var major: String?
    private var profilePicture: String?
    private var friends = [User]()
    
    func set_uid (new_uid: String) {
        uid = new_uid
    }
    func set_email (new_email: String) {
        email = new_email
    }
    func set_name (new_name: String) {
        name = new_name
    }
    func set_university(new_uni: String) {
        university = new_uni
    }
    func set_major (new_major: String) {
        major = new_major
    }
    func set_profile_picture (new_picture: String) {
        profilePicture = new_picture
    }
    func set_friends (friendlist : [User]) {
        friends = friendlist
    }
    
    func userID () -> String {
        if let _ = uid {
            return uid!
        }
        return "xxx"
    }
    
    func userEmail () -> String {
        if let _ = email {
            return email!
        }
        return "xxx"
    }
    
    func userName () -> String {
        if let _ = name {
            return name!
        }
        return "xxx"
    }
    
    func userUniversity () -> String {
        if let _ = university {
            return university!
        }
        return "xxx"
    }
    
    func userMajor () -> String {
        if let _ = major {
            return major!
        }
        return "xxx"
    }
    
    func userProfilePicture () -> String {
        if let _ = profilePicture {
            return profilePicture!
        }
        return "xxx"
    }
    
    
    
    
    
}
