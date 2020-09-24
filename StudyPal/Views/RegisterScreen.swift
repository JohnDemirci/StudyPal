//
//  RegisterScreen.swift
//  StudyPal
//  Created by John Demirci on 9/5/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase


// this protocol is going to be used to share data from the child view to the parent view
protocol UniversityDelegate {
    func retractUni(uniName: String)
}
    
// this protocol is going to be used to share data from the child view to the parent view
protocol MajorDelegate {
    func retractMajor(majorName: String)
}
    
// <This View Controller will pop up once the user clicks the register button>
class RegisterScreen: UIViewController, UIScrollViewDelegate, UniversityDelegate, MajorDelegate {
    func retractUni(uniName: String) {
        university.setTitle(uniName, for: .normal)
    }
    func retractMajor(majorName: String) {
        major.setTitle(majorName, for: .normal)
    }
    /*
     Initilization of a scroll view
     > Main purpose of this scroll view is to enable the app in landscape mode
     */
    let scroll = UIScrollView()
    /*
     Initilization of a Vertical Stack View
     > When we have a Scroll view it is better to use a stack view inside it
     */
    let stackView = UIStackView()
    //********************************
    //********** Text Fields *********
    //********************************
    /*
    Since these textfields are going to be identical when it comes to their dsign
     I created a function that takes a textfield as UITextField, a placehorlder as a String and fieldWidth as a CGFloat
     we pass each one of these text fields to that function and implement their design
     */
    let name = UITextField()
    let email = UITextField()
    let password = UITextField()
    let confirmPassword = UITextField()
    var selectedUniversity: String?
    var selectedMajor: String?
    //***********************************
    //************ Buttons **************
    //***********************************
    /*
     Lookwise these buttons are going to be nearly identical
     I created a function that implements their design similar to what I did with text fields
     */
    let university = UIButton()
    let major = UIButton()
    let submit = UIButton()
    /*
     Here's what goes down when the view loads
     ScrollViewConfiguration -> Setting up the scrollView and attatching it to the screen
     StackViewConfiguration -> Setting up the stackView and attaching to the screen
        Stack view is inside the scroll View we will use it to place our objects
     AddTextFields() -> Initilizes the textfields that are going to be used
     AddButtons -> creates the buttons
     AddCosntraints -> Inserts the objects to the stackview so that the user can see them
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appColor
        scrollViewConfguration()
        stackViewConfguration()
        addTextFields()
        addButtons()
        addConstraints()
    }
}
// ************ SCROLL & STACK VIEW EXTENSION ***************
// we are configuring the views we have implemented at the top
extension RegisterScreen {
    func scrollViewConfguration () {
        // allowing to customize the constraints
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bounces = true
        scroll.delegate = self
        // we are adding out scrollView into our main view
        view.addSubview(scroll)
        // down below we are saying that our scroll view should have the same dimensions as our view
        // except for the top side of our scroll view that should be 50 below of the topside of our main view
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true;
        scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true;
        scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true;
    }
    // self explanatory
    func stackViewConfguration () {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        // each element will have 50 spacing between them
        stackView.spacing = 50
        // after we added our scrollview we are adding a stack view that has the same dimensions
        scroll.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor).isActive = true;
        stackView.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 100).isActive = true;
        stackView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor).isActive = true;
        stackView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -10).isActive = true;
        // this width was necessary because in my tests i had a larger width than expected
        // it was scrolling horizantally
        // after adding this constraint it solved that problem
        stackView.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
    }
}
// *************** TEXT FIELD EXTENSION ************
/*
     > I am using extensions to make the code easier to navigate and to read
     > They provide simplicity
     > In this extension we are focusing on Textfields
*/
extension RegisterScreen: UITextFieldDelegate {
    // this function will call other function to configure the text fields
    // since the text fields are going to be nearly identical
    // we can create a function and pass some parameters
    // that will save some lines of code
    func addTextFields () {
        textfieldConfiguration(txtField: name, placeholder: "name", secureField: false)
        textfieldConfiguration(txtField: email, placeholder: "email", secureField: false)
        textfieldConfiguration(txtField: password, placeholder: "Password", secureField: true)
        textfieldConfiguration(txtField: confirmPassword, placeholder: "Confirm Password", secureField: true)
    }
    // Implementation of the texfields design
    // the function takes textfield and placeholder
    func textfieldConfiguration (txtField: UITextField, placeholder: String, secureField: Bool) {
        txtField.autocapitalizationType = .none
        txtField.autocorrectionType = .no
        txtField.delegate = self
        if secureField /* then */ { txtField.isSecureTextEntry = true }
        // setting translatesAutoresizingMaskIntoConstraints
        // to false allows us to use constrains
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.backgroundColor = .clear
        // setting the borders to a gold color
        // the goldColor is implemented in HexColorImplementation.swift file
        txtField.layer.borderColor = goldColor.cgColor
        // this will give us a Rounded Rectangle
        txtField.layer.cornerRadius = 20
        txtField.textColor = goldColor
        // setting the clipYoBounds true so it will not go over the borders
        // we have a clear background so this may not be necessary
        // however when it comes to password entry the background may chhange to a yellow color which then it goes over the border
        txtField.clipsToBounds = true
        txtField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        txtField.layer.borderWidth = 1
        txtField.textAlignment = .center
        // changing the placeholder color to goldColor
        txtField.attributedPlaceholder = NSAttributedString(string: "\(placeholder)", attributes: [NSAttributedString.Key.foregroundColor: goldColor])
    }
    // this is a predefined function by uikit
    // after the user hits return I want to dismiss the keyboard
    // this function does that exactly
    // this function only works if we set the textfield delegate to self
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
    
// *********** BUTTON EXTENSION **************
/*
     > Here's the button version of previous extension
     > We are going to configure and et the action function of our buttons
*/
extension RegisterScreen {
    // this function will call other functions to add the buttons
    // all buttons are going to be nearly identical
    // they will have some minor differences
    // i tell those differences by passing them in the patameter
    
    //after button is tapped we are going to execute the function inside the #selector
    // the selector will recognize which button is tapped
    // then we are going to use this information to perform actions
    // inside that function based on which button is tapped
    func addButtons () {
        buttonConfiguration(button: university, placeholder: "University")
        buttonConfiguration(button: major, placeholder: "Major")
        buttonConfiguration(button: submit, placeholder: "Submit")
        university.addTarget(self, action: #selector(universityClicked), for: .touchUpInside)
        major.addTarget(self, action: #selector(majorClicked), for: .touchUpInside)
        submit.addTarget(self, action: #selector(submitClicked), for: .touchUpInside)
    }
    
    
    // design implementation of the button
    // one function to rule all the buttons in this view controller
    func buttonConfiguration (button: UIButton, placeholder: String) {
        // rounded rectangle look
        button.layer.cornerRadius = 20
        button.layer.borderColor = goldColor.cgColor
        button.backgroundColor = goldColor
        button.layer.borderWidth = 1
        button.setTitle("\(placeholder)", for: .normal)
        // adding a shadow to the buttons
        button.layer.shadowColor = goldColor.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 6
        button.setTitleColor(appColor, for: .normal)
        // enabling our constraints
        button.translatesAutoresizingMaskIntoConstraints = false
        // I wanted the submit button to have a different width so we are checking that
        // if the placeholder we passed is Submit
        // if it is we give it a special width
        if placeholder == "Submit" {
            button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        } else {
            // if it is any other button then use this
            button.widthAnchor.constraint(equalToConstant: 300).isActive = true
        }
    }
    
    
    
    @objc func submitClicked () {
        animateButtons(sender: submit)
        // do a password check
        // do a email check
        // do stuff with the created variables later
        let passwordCheck = validPasswordCheck()
        let emailCheck = isValidEmail()
        let validName = nameCheck()
        let validUni = universityValidation()
        let validMAjor = majorValidation()
        if passwordCheck.0 && emailCheck && validName && validUni && validMAjor {
            addUserToFirebase()
        }
    }
    // TODO: implement
    @objc func universityClicked () {
        animateButtons(sender: university)
        // go to the university view
        let uniScreen = UniversityScreen()
        uniScreen.delegate = self
        navigationController?.pushViewController(uniScreen, animated: true)
    }
    
    // TODO: Implement
    @objc func majorClicked() {
        animateButtons(sender: major)
        let majScreen = MajorScreen()
        majScreen.delegate = self
        navigationController?.pushViewController(majScreen, animated: true)
    }
}

    

// ************* CONSTRAINT EXTENSION **************
/**
     > This is where we grab our objects and insert them into our views
*/
extension RegisterScreen {
    func addConstraints () {
        // adding the objects tot the stackview here
        stackView.addArrangedSubview(email)
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(password)
        stackView.addArrangedSubview(confirmPassword)
        stackView.addArrangedSubview(university)
        stackView.addArrangedSubview(major)
        stackView.addArrangedSubview(submit)
    }
}
    
// EMAIL validation
extension RegisterScreen {
    func isValidEmail() -> Bool {
        // we are going to be using RegEx to check for the validation
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let check = emailPred.evaluate(with: email.text)
        if check == false {
            // show alert
            let alert = UIAlertController(title: "invalid email", message: "check ur email dumbass", preferredStyle: .alert)
            // add action is just the dismiss button here
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            // presenting the alert here
        }
        return check
    }
}

    
//PASSWORDK VALIDATION TEST
/// <the password needs to pass a certain criteria>
extension RegisterScreen {
    func validPasswordCheck () -> (Bool, String) {
        // passwordCheck is going to be our return value
        // we initilize it with true and valid
        // then check for ways where password may not be valid
        var passwordCheck = (true, "valid")
        // checking if the user entered anything
        if password.text == "" || confirmPassword.text == "" {
            passwordCheck = (false, "no password entry")
        }
        // checking if the passwords matched
        if password.text != confirmPassword.text {
            passwordCheck = (false, "password did not match")
        }
        //checking if the text is nil
        // if not then test the password more
        if password.text != nil {
            if password.text!.count < 8 {
                passwordCheck = (false, "password is less than 8 characters")
            }
            //At least one digit
            if password.text!.range(of: #"\d+"#, options: .regularExpression) == nil {
                passwordCheck = (false, "password needs to have at least one digit")
            }
            //At least one letter
            if password.text!.range(of: #"\p{Alphabetic}+"#, options: .regularExpression) == nil {
                passwordCheck = (false,"password needs to have at least one lette")
            }
            //No whitespace charcters
             if password.text!.range(of: #"\s+"#, options: .regularExpression) != nil {
                 passwordCheck = (false, "password cannot have whitespace characters")
             }
        } else {
            passwordCheck = (false, "password text field is nil")
        }
        // if we end up with an invalid password
        // we will show alert with a messasge
        if passwordCheck.0 == false {
            // show alert
            let alert = UIAlertController(title: "\(passwordCheck.1)", message: "", preferredStyle: .alert)
            // add action is just the dismiss button here
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            // presenting the alert here
            self.present(alert, animated: true, completion: nil)
        }
        return passwordCheck
    }
}
    
// EXTENSION FOR HANDLING NAME
extension RegisterScreen {
    func nameCheck () -> Bool {
        if name.text == nil || name.text == "" {
            let alert = UIAlertController(title: "No name", message: "please enter a name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return false
        }
        return true
    }
}

/*
     After university is clicked we will open up a new view.
     inside that view there is going to be a table view and a search bar
     the user will search for their university and when they lcick their university
     it selects that university and goes back to the previous view
     after it goes back to the previous view it shares data and changes the title of the button to the name of the clciked university
     In this function we checked whether or not the user clicked to the university
*/
extension RegisterScreen {
    func universityValidation () -> Bool {
        if university.currentTitle?.lowercased() == "university" {
            let alert = UIAlertController(title: "No University Selected", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return false
        }
        return true
    }
    // same thing with what we did to university but this time it's with major
    func majorValidation () -> Bool {
        if major.currentTitle?.lowercased() == "major" {
            let alert = UIAlertController(title: "No major Selected", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            return false
        }
        return true
    }
}

/*
 EXTENSION TO ADD THE USER TO THE CLOUD DATABASE
 */
extension RegisterScreen {
    func addUserToFirebase () {
        let newUser = User(email: email.text!,
                           name: name.text!,
                           password: password.text!,
                           university: university.titleLabel!.text!,
                           major: major.titleLabel!.text!)
        // using the firebase createuser function to add the user
        Auth.auth().createUser(withEmail: newUser.email, password: newUser.password) { (result, err) in
            if err != nil {
                let alert = UIAlertController(title: "error", message: "error", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
            } else {
                // userdata will containt the key : value pairs each user will have in theri account
                let userData =
                            ["name" : newUser.name,
                            "university" : newUser.university,
                            "major" : newUser.major,
                            "uid" : result!.user.uid]
                let db = Firestore.firestore()
                db.collection("Users").addDocument(data: userData) { (errorMes) in
                    if errorMes != nil {
                        print("\(String(describing: errorMes?.localizedDescription))")
                    }
                }
            }
        }
        let successAlert = UIAlertController(title: "SUCCESS", message: "Registration Completed", preferredStyle: .alert)
        successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (ALRT) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(successAlert, animated: true, completion: nil)
    }
}


