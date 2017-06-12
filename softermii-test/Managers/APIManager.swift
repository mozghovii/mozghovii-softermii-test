//
//  APIManager.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

class APIManager: NSObject {
    
    var headOfUser = [String: Any]()
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        return instance
    }()
    var sessionManager:SessionManager = SessionManager()

    func getAccessTokenWithParams(parameters: Parameters?, success: @escaping () -> (), failure: @escaping () -> ()) {
        sessionManager.request(Globals.APIParams.accessTokenEndPoint, method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                if response.response?.statusCode == 200 {
                    let json = JSON(value)
                    print(response.value!)
                    self.headOfUser = ["access_token": json["access_token"]]
                    success()
                }
                else {
                    let json = JSON(value)
                    let errorMessage = json["meta"]["error_message"] .rawString()
                    let error = errorMessage?.convertToError(statusCode: (response.response?.statusCode)!)
                    ErrorAlertManager.manageError(error: error, action: { (action) in
                        failure()
                    }, vc: nil)
                }
            case .failure:
                if let error = response.result.error as? AFError {
                    ErrorAlertManager.manageError(error: error, action: { (action) in
                        failure()
                    }, vc: nil)
                    
                }
            }
        }
    }
    func getUserInfo (success: @escaping (User) -> (), failure: @escaping () -> ()) {
        self.headOfUser = ["access_token": "4233457869.9a32015.63f877505a86455f9434460432704e64"]

        sessionManager.request("https://api.instagram.com/v1/users/self/", method: .get, parameters: self.headOfUser).responseJSON { (response) in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                let user = User(respons: json)
                success(user)
                break;
            case.failure:
                print(response.error!)
                break;
            }
        }
    }
    
    func getSelfMediaRecent(parameters: Parameters?, success: @escaping (Array<Any>) -> (), failure: @escaping () -> ()) {
        self.headOfUser = ["access_token": "4233457869.9a32015.63f877505a86455f9434460432704e64"]

        sessionManager.request("https://api.instagram.com/v1/users/self/media/recent", method: .get, parameters:self.headOfUser).responseJSON { (response) in
            switch response.result {
            case.success(let value):
                let json = JSON(value)
                let arrJSON = json["data"].arrayValue
                var arrayObjects = Array<Any>()
                
                for index in 0...arrJSON.count-1 {
                    let aObject = MediaModel.init(respons: arrJSON[index])
                    arrayObjects.append(aObject)
               }
                success(arrayObjects)
                print(response.value!)
                break;
            case.failure:
                print(response.error!)
                break;
            }
        }
}

}

