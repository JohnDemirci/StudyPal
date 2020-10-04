//
//  ViewController.swift
//  StudyPal
//
//  Created by John Demirci on 9/5/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit

import FirebaseAuth
import FirebaseFirestore
import Firebase

class HomeView: UIViewController {
    
    // this blank view is going to be used to adjust the elements in the screen
    // it will work as a spacer
    var blankView : UIView = {
        let blank = UIView()
        blank.translatesAutoresizingMaskIntoConstraints = false
        blank.backgroundColor = .clear
        blank.heightAnchor.constraint(equalToConstant: 10).isActive = true
        return blank
    }()
    var homeScrollView = UIScrollView()
    var homeStackView = UIStackView()
    var homeUsername = UITextField()
    var homePassword = UITextField()
    var rememberMeButton = UIButton()
    var homeRegister = UIButton()
    var homeLogin = UIButton()
    var buttonHStack = UIStackView()
    
    
    /*
     I prefer not to have a lot of logic inside my viewDidLoad method
     that is why a lot of things are divided into small pieces
     i am using extensions to make the code readable
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        // appColor and goldColor are implemented in
        // ColorImplementation.swift file
        view.backgroundColor = appColor
        scrollViewConfiguration()
        stackViewConfiguration()
        addTextFields()
        addButtons()
        homeViewConstraints()
        // TODO:
        /*
         CHECK IF REMEMBER ME WAS SELECTEED
         IF IT WAS CHECK CORE DATA
         GRAB THE DATA AND LOGIN
         ELSE
         DO NOTHING
         */
    }
    // we are creating a closure of the logo
    // this will automatically all itself and initilize itself
    let logo : UIImageView = {
        let image = UIImageView(image: UIImage(named: "StudyPalLogo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 300).isActive = true
        image.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return image
    }()
}


// ****** SCROLLVIEW EXTENSION ********
extension HomeView: UIScrollViewDelegate {
    // configuring the scroll view
    // this is the first thing to be called when launching the view
    // imagine this as the bottom of the view hierarchy
    func scrollViewConfiguration () {
        homeScrollView.backgroundColor = .clear
        // statement below will enable us to use constraints
        homeScrollView.translatesAutoresizingMaskIntoConstraints = false
        homeScrollView.delegate = self
        homeScrollView.bounces = true
        homeScrollView.indicatorStyle = .black
        view.addSubview(homeScrollView)
        // setting the constraints of the scrollview
        // i chose to do this here instead of the constraint function
        // because it would make it more readable and
        // since the function is named scroll view configuration
        // it seemed like it would fit well

        
        homeScrollView.frame = view.bounds
        homeScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        homeScrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        homeScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        homeScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        homeScrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        homeScrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        
    }
    // after scroll view is called then we add a stackView
    // this will cover the scrollView
    // we will insert our objects into this stack
    func stackViewConfiguration () {
        // basic configurations
        homeStackView.translatesAutoresizingMaskIntoConstraints = false
        homeStackView.axis = .vertical
        homeStackView.distribution = .fillProportionally
        homeStackView.alignment = .center
        homeStackView.spacing = 30
        // adding to the view and setting the constraints down
        // same reason as how i did the scroll view
        // it is more readable if they are here instead of the constraint func
        homeScrollView.addSubview(homeStackView)
        homeStackView.topAnchor.constraint(equalTo: homeScrollView.topAnchor).isActive = true
        homeStackView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor).isActive = true
        homeStackView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor).isActive = true
        homeStackView.bottomAnchor.constraint(equalTo: homeScrollView.bottomAnchor).isActive = true
        homeStackView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor).isActive = true
        // we are creating a vertical stack that will store two buttons
        // horizantally (register and login buttons)
        // we will add this stack into the vertical stack we jsut created
        buttonHStack.translatesAutoresizingMaskIntoConstraints = false
        buttonHStack.axis = .horizontal
        buttonHStack.distribution = .fillEqually
        buttonHStack.alignment = .center
        buttonHStack.spacing = 50
    }
}

// ******* TEXTFIELD EXTENSION *********
extension HomeView: UITextFieldDelegate {
    // this function will call other function to configure the text fields
    // since the text fields are going to be nearly identical
    // we can create a function and pass some parameters
    // that will save some lines of code
    func addTextFields () {
        designTextField(textField: homeUsername, placeholder: "Username", secureField: false)
        designTextField(textField: homePassword, placeholder: "Password", secureField: true)
    }
    // one function to rule the textfields in this view controller
    func designTextField (textField: UITextField, placeholder: String, secureField: Bool) {
        // no capitilization at the beginning
        textField.autocapitalizationType = .none
        // no autocorrect
        textField.autocorrectionType = .no
        // setting the delegates
        textField.delegate = self
        // checking if the textfield should be secure
        if secureField {textField.isSecureTextEntry = true}
        // setting translatesAutoresizingMaskIntoConstraints
        // to false allows us to use constrains
        textField.translatesAutoresizingMaskIntoConstraints = false
        // setting the background color to clear so it can be one with the app color
        textField.backgroundColor = .clear
        // setting the borders to a gold color
        // the goldColor is implemented in HexColorImplementation.swift file
        textField.layer.borderColor = goldColor.cgColor
        // setting the corner radius to 20
        // this will give us a Rounded Rectangle
        textField.layer.cornerRadius = 20
        // setting the typed text color of the text field to goldColor
        textField.textColor = goldColor
        // setting the clipYoBounds true so it will not go over the borders
        // we have a clear background so this may not be necessary
        // however when it comes to password entry the background may chhange to a yellow color which then it goes over the border
        textField.clipsToBounds = true
        textField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        textField.snapshotView(afterScreenUpdates: true)
        // setting the borderWidth to 1
        // i did not want the border to be too thick
        textField.layer.borderWidth = 1
        // setting the allignment to center
        // I could set it to leading and have a little offset to the right in the future
        textField.textAlignment = .center
        // changing the placeholder color to goldColor
        textField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: goldColor])
    }
    
    // after the user hits return I want to dismiss the keyboard
    // this function does that exactly
    // this function only works if we set the textfield delegate to self
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
}

// ********* BUTTON EXTENSION ************
extension HomeView {
    // this function will call other functions to add the buttons
    // all buttons are going to be nearly identical
    // they will have some minor differences
    // i tell those differences by passing them in the patameter
    func addButtons () {
        designButton(button: rememberMeButton, placegolder: "Remember Me ❌", buttonWidth: 200, buttonHeight: 35)
        designButton(button: homeRegister, placegolder: "Register", buttonWidth: 150, buttonHeight: 35)
        designButton(button: homeLogin, placegolder: "Login", buttonWidth: 150, buttonHeight: 35)
    }
    // one function to rule all the buttons in this view controller
    func designButton (button : UIButton, placegolder: String, buttonWidth: CGFloat, buttonHeight: CGFloat) {
        // rounded rectangle look
        button.layer.cornerRadius = 20
        // goldcolor in the border
        button.layer.borderColor = goldColor.cgColor
        // I wanted the buttons to stand out from textFields
        // So i made their background goldcolor
        // and i changed their textColor to appColor
        button.backgroundColor = goldColor
        // little border width
        button.layer.borderWidth = 1
        // the text inside the button as the placeholder
        button.setTitle("\(placegolder)", for: .normal)
        // adding a shadow to the buttons
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
    // Function that is executed whenever a button i clicked
    // we are passing a UIButton to recognize which button is clicked
    @objc func buttonTapped (sender: UIButton) {
        // testing if the function is working as intended with the statement below
        print("\(sender.currentTitle!)")
        // we are going to implement our own button animation
        animateButtons(sender: sender)
        // we will call different functions based on which button is clicked
        // i wanted all buttons to share the same animation so this is more like an
        // animation function
        // now i write a switch statement and call functions based on which button is pressed
        // i am sure this is a pretty bad way to do this i might change it later
        // we are unwrapping optional value here since it could be niil
        /*
         TODO: CODE BELOW IS BAD PLS OPTIMIZE IT
         */
        if let title = sender.currentTitle {
            switch title {
                // if the remember me button is tapped we toggle the selected value
                // and change the appearance
                // then we tell the core data to remember the login information
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
    // register button tapped function
    // we just want to navigate to the registerscreen
    func RegisterTapped () {
        let regScreen = RegisterScreen()
        regScreen.title = "Register"
        navigationController?.pushViewController(regScreen, animated: true)
    }
    
    
    
    /*
     we connect to our database in the cloud and check the email and password
     if they match it means the user entered the right info
     in case of a match we go to the log in screen
     
     note: the username is actually the email address
     */
    func loginTapped () {
        if homeUsername.text != nil && homePassword.text != nil {
            let email = homeUsername.text!
            let password = homePassword.text!
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    /*
                     TODO: IMPLEMENT AN ALERT IN CASE LOGIN IS NOT SUCCESSFUL
                     */
                    let alert = UIAlertController(title: "Error", message: "email or password did not match", preferredStyle: .alert)
                    // add action is just the dismiss button here
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    // presenting the alert here
                    self.present(alert, animated: true, completion: nil)
                    print(err?.localizedDescription as Any )
                }
                else {
                    let db = Firestore.firestore()
                    var mjr: String?
                    let userIdentification = result!.user.uid
                    db.collection("Users").document(userIdentification).getDocument { (document, err) in
                        let docData = document?.data()
                        mjr = docData!["major"] as? String
                        let loggedin = LoggedInView()
                        loggedin.userId = userIdentification
                        loggedin.title = mjr
                        self.navigationController?.pushViewController(loggedin, animated: true)
                    }
                }
            }
        }
    }
}

// ********* CONSTRAINT EXTENSION ***********
extension HomeView {
    // function to add stuff to the views
    func homeViewConstraints () {
        // adding the applogo image as the first thing to the stack
        homeStackView.addArrangedSubview(logo)
        // after the logo we are adding the textfields
        homeStackView.addArrangedSubview(homeUsername)
        homeStackView.addArrangedSubview(homePassword)
        // then the textfield button
        homeStackView.addArrangedSubview(rememberMeButton)
        // now we want to add two buttons to a stack
        // and we want to add that stack to the stack we already created
        // code below does that
        
        homeStackView.addArrangedSubview(blankView)
        buttonHStack.addArrangedSubview(homeRegister)
        buttonHStack.addArrangedSubview(homeLogin)
        homeStackView.addArrangedSubview(buttonHStack)
    }
}
