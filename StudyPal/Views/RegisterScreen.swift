    //
//  RegisterScreen.swift
//  StudyPal
//  Created by John Demirci on 9/5/20.
//  Copyright © 2020 DemirciJohn. All rights reserved.
//

import UIKit


// <This View Controller will pop up once the user clicks the register button>
class RegisterScreen: UIViewController, UIScrollViewDelegate {
    
    /**
     Initilization of a scroll view
     > Main purpose of this scroll view is to enable the app in landscape mode
     */
    let scroll = UIScrollView()
    /**
     Initilization of a Vertical Stack View
     > When we have a Scroll view it is better to use a stack view inside it
     */
    let stackView = UIStackView()
    
    //********************************
    //********** Text Fields *********
    //********************************
    /**
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
    
    
    //********************************
    //************ Buttons ***********
    //********************************
    /**
     Lookwise these buttons are going to be nearly identical
     I created a function that implements their design similar to what I did with text fields
     */
    let university = UIButton()
    let major = UIButton()
    let submit = UIButton()
    

    /**
     Here's what goes down when the view loads
     > we call the textfield delegate function to enable more functionality with our textfields
     > we implement the design of each of our textfields by calling texfieldConfiguration function
     > Similarly we are calling buttonConfiguration function to implement the design of outr buttons
     > Scroll and Stack View configuration functions are called for their design
     > And addconstraints function is called to place the objects in our app
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
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bounces = true
        scroll.delegate = self
        
        // we are adding out scrollView into our main view
        view.addSubview(scroll)
        // down below we are saying that our scroll view should have the same dimensions as our view
        // except for the top side of our scroll view that should be 50 below of the topside of our main view
        scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true;
        scroll.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true;
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
        stackView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true;
        // this width was necessary because in my tests i had a larger width than expected
        // it was scrolling horizantally
        // after adding this constraint it solved that problem
        stackView.widthAnchor.constraint(equalTo: scroll.widthAnchor).isActive = true
    }
}
    

    
    
// *************** TEXT FIELD EXTENSION ************
/**
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
        
        // first letter is lowercase
        txtField.autocapitalizationType = .none
        
        
        // no autocorrect
        txtField.autocorrectionType = .no
        // enabling some advanced textfield functionalities
        txtField.delegate = self
        // checking if the textfield should be secure
        if secureField /* then */ { txtField.isSecureTextEntry = true }
        // setting translatesAutoresizingMaskIntoConstraints
        // to false allows us to use constrains
        txtField.translatesAutoresizingMaskIntoConstraints = false
        // setting the background color to clear so it can be one with the app color
        txtField.backgroundColor = .clear
        // setting the borders to a gold color
        // the goldColor is implemented in HexColorImplementation.swift file
        txtField.layer.borderColor = goldColor.cgColor
        // setting the corner radius to 20
        // this will give us a Rounded Rectangle
        txtField.layer.cornerRadius = 20
        // setting the typed text color of the text field to goldColor
        txtField.textColor = goldColor
        // setting the clipYoBounds true so it will not go over the borders
        // we have a clear background so this may not be necessary
        // however when it comes to password entry the background may chhange to a yellow color which then it goes over the border
        txtField.clipsToBounds = true
        // setting the width of the textfield to 300
        txtField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        // setting the borderWidth to 1
        // i did not want the border to be too thick
        txtField.layer.borderWidth = 1
        // setting the allignment to center
        // I could set it to leading and have a little offset to the right in the future
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
/**
     > Here's the button version of previous extension
     > We are going to configure and et the action function of our buttons
*/
extension RegisterScreen {
    // this function will call other functions to add the buttons
    // all buttons are going to be nearly identical
    // they will have some minor differences
    // i tell those differences by passing them in the patameter
    func addButtons () {
        buttonConfiguration(button: university, placeholder: "University")
        buttonConfiguration(button: major, placeholder: "Major")
        buttonConfiguration(button: submit, placeholder: "Submit")
    }
    
    
    // design implementation of the button
    // one function to rule all the buttons in this view controller
    func buttonConfiguration (button: UIButton, placeholder: String) {
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
        button.setTitle("\(placeholder)", for: .normal)
        
        // adding a shadow to the buttons
        button.layer.shadowColor = goldColor.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 6
        
        
        //after button is tapped we are going to execute the function inside the #selector
        // the selector will recognize which button is tapped
        // then we are going to use this information to perform actions
        // inside that function based on which button is tapped
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        // setting the titlecolor (placeholder)
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
    // Function that is executed whenever a button i clicked
    // we are passing a UIButton to recognize which button is clicked
    @objc func buttonTapped (sender: UIButton) {
        // testing if the function is working as intended with the statement below
        print("\(sender.currentTitle!)")
        // we are going to implement our own button animation
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: CGFloat(0.20), initialSpringVelocity: CGFloat(6.0), options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                sender.transform = CGAffineTransform.identity
            },
            completion: { Void in()  }
        )
        
        if let title = sender.currentTitle {
            switch title {
            case "Submit":
                submitClicked()
                break
            case "University":
                universityClicked()
                break
            case "Major":
                majorClicked()
                break
            default:
                print("oof")
            }
        }
    }
    
    
    func submitClicked () {
        // do a password check
        // do a email check
        // do stuff with the created variables later
        let passwordCheck = validPasswordCheck()
        let emailCheck = isValidEmail()
        let validName = nameCheck()
        let validUni = universityValidation()
        let validMAjor = majorValidation()
        if passwordCheck.0 && emailCheck && validName && validUni && validMAjor {
            print("yo")
        }
    }
    // TODO: implement
    func universityClicked () {
        navigationController?.pushViewController(UniversityScreen(), animated: true)
    }
    
    // TODO: Implement
    func majorClicked() {
        
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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let check = emailPred.evaluate(with: email.text)
        if check == false {
            // show alert
            let alert = UIAlertController(title: "invalid email", message: "check ur email dumbass", preferredStyle: .alert)
            // add action is just the dismiss button here
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            // presenting the alert here
            self.present(alert, animated: true, completion: nil)
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
    
extension RegisterScreen {
    func universityValidation () -> Bool {
        if university.currentTitle?.lowercased() == "university" {
            return false
        }
        return true
    }
    
    
    func majorValidation () -> Bool {
        if major.currentTitle?.lowercased() == "major" {
            return false
        }
        return true
    }
}

