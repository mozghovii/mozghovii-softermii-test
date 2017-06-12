//
//  Globals.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit

struct Globals {
    
    // MARK - API Requests params:
    struct APIParams {
        static let instagramClientID = "9a32015c06d2456fa3d46d34e8f01388"
        static let instagramSecret = "81e9eec6db80468ca36ba3a258ff76fb"
        static let redirectURI = "https://staging.recruit.com/Iam/signin-instagram"
        static let authorizationEndPoint = "https://api.instagram.com/oauth/authorize/"
        static let accessTokenEndPoint = "https://api.instagram.com/oauth/access_token/"
        static let supportNumer                     = "800500700"
        
        struct LoginErrorsTypes {
            
        }
    }
    
    struct StoryboardsName {
        static let main                             = "Main"
    }
    
    struct GeneralConstants {
        static let detailViewController             = "detailViewController"
        
    }
    
    struct SegueIdentefires {
        static let loginSuccessPerform              = "loginSuccessPerform"
        static let loginViaOAuth                    = "loginViaOAuth"
        
    }
    
    struct CellIdentifiers {
        static let HeaderReusableView               = "HeaderReusableView"
        static let MediaCell                        = "Cell"

        
    }
    
    struct UserModelJSONKeys {
        static let data                             = "data"
        static let username                         = "username"
        static let profile_picture                  = "profile_picture"
        static let counts                           = "counts"
        static let media                            = "media"
        static let followed_by                      = "followed_by"
        static let follows                          = "follows"
        static let posts                            = "posts"
        static let followers                        = "followers"
        static let following                        = "following"

    }
    
    struct MediaModelJSONKeys {
        static let images                           = "images"
        static let url                              = "url"
        static let low_resolution                   = "low_resolution"
        static let standard_resolution              = "standard_resolution"
        static let thumbnail                        = "thumbnail"
    }
    
}
