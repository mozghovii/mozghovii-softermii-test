//
//  User.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
import SwiftyJSON

class User {
    
    var userName:String?
    var posts:(name:String, count: String)?
    var followers:(name:String, count: String)?
    var following:(name:String, count: String)?
    var avatarURL:URL?
    init(respons: JSON) {
        self.userName = respons[Globals.UserModelJSONKeys.data][Globals.UserModelJSONKeys.username].stringValue
        self.avatarURL = URL(string: respons[Globals.UserModelJSONKeys.data][Globals.UserModelJSONKeys.profile_picture].stringValue)
        self.posts = (Globals.UserModelJSONKeys.posts,respons[Globals.UserModelJSONKeys.data][Globals.UserModelJSONKeys.counts][Globals.UserModelJSONKeys.media].stringValue)
        self.followers = (Globals.UserModelJSONKeys.followers,respons[Globals.UserModelJSONKeys.data][Globals.UserModelJSONKeys.counts][Globals.UserModelJSONKeys.followed_by].stringValue)
        self.following = (Globals.UserModelJSONKeys.following,respons[Globals.UserModelJSONKeys.data][Globals.UserModelJSONKeys.counts][Globals.UserModelJSONKeys.follows].stringValue)
    }
}
