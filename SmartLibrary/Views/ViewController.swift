//
//  ViewController.swift
//  SmartLibrary
//
//  Created by Кирилл Галимзянов on 25.02.2020.
//  Copyright © 2020 Kirill Galimzyanov. All rights reserved.
//

import Foundation
import UIKit

import FirebaseAuth
import LGButton
import FirebaseFirestore
import Firebase

class ViewController: UIViewController, UITextFieldDelegate {
    
    var currentUser: User!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var logInButton: LGButton!
    
    var allTextFields: [UITextField] = []
    
    let db = Firestore.firestore()
    
    var ref: DatabaseReference!
    // THERE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        self.setGradientBackground(colours: [Constants.Colours.firstColourGradient,
                                             Constants.Colours.secondColourGradient])
        
        // errorLabel.textColor = Constants.Colours.stateColourTextField
        
        // Set textfields' delegates for handling touches of outside it
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        allTextFields.append(emailTextField)
        allTextFields.append(passwordTextField)
    }
    
    @IBAction func tappedLogin(_ sender: Any) {
        
        // Validate the fields
        let validation = validateFields()
        
        for textFieldValidate in validation.1 {
            if textFieldValidate.1 {
                
                changeColourTextField(textFieldValidate.0 as! RoundTextField,
                                      Constants.Colours.stateColourTextField)
            } else {
                
                changeColourTextField(textFieldValidate.0 as! RoundTextField,
                                      Constants.Colours.errorColourTextField)
            }
        }
        
        if let errorMessage = validation.0 {
            showError(errorMessage)
            
        } else {
            showError("")
            
            logInButton.isLoading = true
            
            // Create cleaned version of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
            // Sign In to the system
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, err) in
                // Check for errors
                if err != nil {
                            
                    // There was an error login to the system
                    self.showError("Incorrect login or password")
                    return
                }
            }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let db = Firestore.firestore().collection(Constants.Firebase.pathToUsers).document(uid)
            db.getDocument { (snapshot, err) in
                self.logInButton.isLoading = false
                
                if let err = err {
                    self.showError(err.localizedDescription)
                } else {
                    guard let snap = snapshot else { return }
                    
                    let data = snap.data()
                    
                    guard let phone = data!["Phone"] as? String else { return }
                    guard let title = data!["Title"] as? String else { return }
                    guard let points = data!["Points"] as? Int else { return }
                    guard let favourite_books = data!["Favourite_books"] as? [String] else { return }
                    guard let taken_books = data!["Taken_books"] as? [String] else { return }
                    
                    self.currentUser = User(uid: uid,
                                            phone: phone,
                                            title: title,
                                            taken_books: taken_books,
                                            favourite_books: favourite_books,
                                            points: points)
                    
                    self.transitionToHome()
                }
            }
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MainTabBarController {
            let vc = segue.destination as? MainTabBarController
            vc?.currentUser = currentUser
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
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
    
    func showError(_ message: String) {
        errorLabel.text! = message
    }

    func transitionToHome() {
        performSegue(withIdentifier: Constants.Storyboard.performSegueToHomeBC, sender: self)
    }
}

