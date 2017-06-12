//
//  LoginViewController.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,WebLoginControllerDelegate {

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
    
    @IBAction func loginViaOAuthPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: Globals.SegueIdentefires.loginViaOAuth, sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destVC = segue.destination as? WebLoginController {
            
            destVC.delegate = self
            
        }
    }
    func didFinishLogin() {
        self.performSegue(withIdentifier: "MediaCollectionController", sender: self)
        
        print("12")
    }

}
