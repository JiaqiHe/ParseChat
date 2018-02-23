//
//  LoginViewController.swift
//  parseChat
//
//  Created by Jiaqi He on 2/21/18.
//  Copyright © 2018 Jiaqi He. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func OnSignup(_ sender: Any) {
        registerUser()
    }
    
    
    func registerUser() {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        if((usernameField.text?.isEmpty)! || (passwordField.text?.isEmpty)!) {
            let alertController = UIAlertController(title: "Sign Up Error", message: "Missing Username/Password", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        } else {
            // call sign up function on the object
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
//                    print(error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
        }
    }
    
    @IBAction func OnLogin(_ sender: Any) {
        loginUser()
    }
    
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here.
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
