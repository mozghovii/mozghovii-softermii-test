//
//  ErrorAlertManager.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//


import UIKit
import Alamofire

class ErrorAlertManager: UIAlertController {

    class func manageError(error: Error?, action: ((UIAlertAction)->())?, vc: UIViewController?)  {
        let title = "Error"
        var message = error?.localizedDescription
        if ((error as NSError?) != nil) {
            message = (error! as NSError).domain
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: action)
        alert.addAction(action)
        if (vc != nil) {
            vc?.present(alert, animated: true, completion: { _ in })
        }
        else {
            var rootVC: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
            while ((rootVC?.presentedViewController) != nil) {
                rootVC = rootVC?.presentedViewController
            }
            rootVC?.present(alert, animated: true, completion: { _ in })
        }
    }
}

