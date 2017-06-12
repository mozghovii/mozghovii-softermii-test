//
//  MediaModel.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import UIKit
import SwiftyJSON

class MediaModel {
    var lowResolutionURL:URL?
    var standardResolutionURL:URL?
    var thumbnail:URL?
    init(respons: JSON) {
        lowResolutionURL = respons[Globals.MediaModelJSONKeys.images][Globals.MediaModelJSONKeys.low_resolution][Globals.MediaModelJSONKeys.url].url
        standardResolutionURL = respons[Globals.MediaModelJSONKeys.images][Globals.MediaModelJSONKeys.standard_resolution][Globals.MediaModelJSONKeys.url].url
        thumbnail = respons[Globals.MediaModelJSONKeys.images][Globals.MediaModelJSONKeys.thumbnail][Globals.MediaModelJSONKeys.url].url
    }

}
