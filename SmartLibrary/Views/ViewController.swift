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

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Replace a simple UIButton to View with class as LGButton and then delete UIHelpers
        
        self.setGradientBackground(colours: [Constants.Colours.firstColourGradient, Constants.Colours.secondColourGradient])
        
        // Set textfields' delegates for handling touches of outside it
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    @IBAction func tappedLogin(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show erro message
            showError(error!)
        } else {
            
            // Create cleaned version of the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Sign In to the system
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error login to the system
                    self.showError("Error login user")
                }
            }
        }
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message.
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let mainTabBarController = segue.destination as? MainTabBarController {
            
            mainTabBarController.email = emailTextField.text
            mainTabBarController.password = passwordTextField.text
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if let _ = Auth.auth().currentUser {
            
            self.performSegue(withIdentifier: Constants.Stroyboard.performSegueToHomeBC, sender: self)
        }
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
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
}

