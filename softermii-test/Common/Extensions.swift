//
//  Extensions.swift
//  softermii-test
//
//  Created by Sergey Mozgovoy on 17/06/2017.
//  Copyright © 2017 Sergey Mozgovoy. All rights reserved.
//

import Foundation
import UIKit

// MARK - String Extensions:

extension String {
    func convertToError(statusCode: Int) -> NSError {
        let error = NSError(domain: self, code: statusCode, userInfo: nil)
        return error
    }
}
