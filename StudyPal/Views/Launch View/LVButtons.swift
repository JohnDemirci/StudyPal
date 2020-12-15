//
//  LVButtons.swift
//  StudyPal
//
//  Created by John Demirci on 12/12/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
// ********* BUTTON EXTENSION ************
extension HomeView {
    func addButtons () {
        designButton(button: rememberMeButton, placegolder: "Remember Me ❌", buttonWidth: 200, buttonHeight: 35)
        designButton(button: homeRegister, placegolder: "Register", buttonWidth: 150, buttonHeight: 35)
        designButton(button: homeLogin, placegolder: "Login", buttonWidth: 150, buttonHeight: 35)
    }

    
    func designButton (button : UIButton, placegolder: String, buttonWidth: CGFloat, buttonHeight: CGFloat) {
        button.layer.cornerRadius = 12
        button.layer.borderColor = goldColor.cgColor
        button.backgroundColor = goldColor
        button.layer.borderWidth = 1
        button.setTitle("\(placegolder)", for: .normal)
        button.layer.shadowColor = goldColor.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 6
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        button.setTitleColor(appColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
    @objc func buttonTapped (sender: UIButton) {
        print("\(sender.currentTitle!)")
        animateButtons(sender: sender)
        /*
         TODO: CODE BELOW IS BAD PLS OPTIMIZE IT
         */
        if let title = sender.currentTitle {
            switch title {
            case "Remember Me ❌":
                rememberMeButton.setTitle("Remember Me ✅", for: .normal)
                break
            case "Remember Me ✅":
                rememberMeButton.setTitle("Remember Me ❌", for: .normal)
                // TODO: USE CORE DATA TO REMEMBER THE USER
                break
            case "Register":
                RegisterTapped()
                break
            case "Login":
                loginTapped()
                break
            default:
                print("sup")
            }
        }
    }

    
    func RegisterTapped () {
        let regScreen = RegisterScreen()
        regScreen.title = "Register"
        navigationController?.pushViewController(regScreen, animated: true)
    }

    
    func loginTapped () {
        // make validations
        if validated() {
            let email = homeUsername.text!
            let password = homePassword.text!
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.show_error(title: "Error", message: "Invalid Username or Password")
                    return
                }
                let loggedInUser = User()
                loggedInUser.set_uid(new_uid: result!.user.uid)
                self.get_user_data(usr: loggedInUser)
            }
        }
    }
    
    
    func get_user_data (usr: User) {
        let db = Firestore.firestore()
        let eml = homeUsername.text!
        db.collection(collection.user).document(eml).addSnapshotListener { (user_info, err) in
            if err != nil {
                self.show_error(title: "Error", message: "")
                return
            }
            if user_info?.data() == nil {
                self.show_error(title: "Error", message: "Could not grab user information")
                return
            }
            let info = user_info!.data()
            usr.set_email(new_email: info![field.email]! as! String)
            usr.set_major(new_major: info![field.major] as! String)
            usr.set_university(new_uni: info![field.university] as! String)
            usr.set_profile_picture(new_picture: info![field.profilePicture] as! String)
            let next_view = LoggedInView()
            next_view.user = usr
            next_view.title = usr.userMajor()
            self.navigationController?.pushViewController(next_view, animated: true)
        }
    }
}
