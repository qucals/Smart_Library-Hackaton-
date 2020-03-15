//
//  RegisterViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 01.03.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

import FirebaseAuth
import FirebaseFirestore
import LGButton

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
        
    @IBOutlet weak var signUpButton: LGButton!
    
    var allTextFields: [UITextField] = []
    
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        allTextFields.append(phoneTextField)
        allTextFields.append(emailTextField)
        allTextFields.append(passwordTextField)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if touches.first != nil {
        
            view.endEditing(true)
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message.
    func validateFields() -> (String?, [(UITextField, Bool)]) {
        
        var returnValues: (String?, [(UITextField, Bool)]) = (nil, [])
        
        for textField in allTextFields {
            if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                
                returnValues.0 = "Please fill all fields"
                returnValues.1.append((textField, false))
                
            } else {
                
                returnValues.1.append((textField, true))
            }
        }
        
        return returnValues
    }
    
    @IBAction func tappedSignUp(_ sender: Any) {
    
        // Validate the fields
        let validation = validateFields()
        
        for textFieldValidate in validation.1 {
            if textFieldValidate.1 {
                
                changeColourTextField(textFieldValidate.0 as! RoundTextField,
                                      UIColor.groupTableViewBackground)
            } else {
                
                changeColourTextField(textFieldValidate.0 as! RoundTextField,
                                      Constants.Colours.errorColourTextField)
            }
        }
        
        if let errorMessage = validation.0 {
            
            // There's something wrong with the fields, show error message
            showError(errorMessage)
        } else {
            showError("")
            
            signUpButton.isLoading = true
            
            // Create cleaned version of the data
            let phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                self.signUpButton.isLoading = false
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    
                    // User was created successfully, now story the username and id card
                    let db = Firestore.firestore()
                    
                    db.collection("users").document(result!.user.uid).setData(["Phone": phone,
                                                                               "Points": 0,
                                                                               "Taken_books": [],
                                                                               "Favourite_books": [],
                                                                               "Title": "Новичок",
                                                                               "Max_points": 0]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data")
                        }
                    }
                    
                    self.currentUser = User(uid: result!.user.uid, phone: phone,
                                title: "Новичок", taken_books: [], favourite_books: [], points: 0)
                    
                    self.transitionToHomeBC()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainTabBarController {
            let vc = segue.destination as? MainTabBarController
            vc?.currentUser = currentUser
        }
    }
    
    func transitionToHomeBC() {
        performSegue(withIdentifier: Constants.Storyboard.performSegueToHomeBC, sender: self)
    }
    
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}
