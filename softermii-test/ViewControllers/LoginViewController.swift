//
//  LoginViewController.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,WebLoginControllerDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destVC = segue.destination as? WebLoginController {
            destVC.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first?.view?.isEqual(view))! {
            view.endEditing(true)
        }
    }
    // MARK: - WebLoginControllerDelegate
    func didFinishLogin() {
        self.performSegue(withIdentifier: "MediaCollectionController", sender: self)
    }
    
    //MARK: - Actions
    
    @IBAction func loginViaOAuthPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Globals.SegueIdentefires.loginViaOAuth, sender: self)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if emailTextField.text?.isValidEmail() == false {
            let error = Globals.ErrorMessages.invalidEmail.convertToError(statusCode: 500)
            ErrorAlertManager.manageError(error: error, action: nil, vc: self)
            emailTextField.shake(count: 10, for: 0.2, withTranslation: 20)
        } else {
            if passwordField.text?.isValidPassword() == false {
                let error = Globals.ErrorMessages.invalidPassword.convertToError(statusCode: 500)
                ErrorAlertManager.manageError(error: error, action: nil, vc: self)
                passwordField.shake(count: 10, for: 0.2, withTranslation: 20)
            }
        }
    }
}
