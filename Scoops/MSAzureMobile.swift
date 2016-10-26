//
//  Azure.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class MSAzureMobile: NSObject {
    
    static let MOBILE_SERVICE   = "https://boot3-mbass.azurewebsites.net"
    static let BLOB_ENDPOINT    = "https://boot3jacobo.blob.core.windows.net/"
    
    static var client: MSClient = MSClient(applicationURL: URL(string: MOBILE_SERVICE)!)
    static var model: [Dictionary<String, AnyObject>]? = []
    static var posts: MSTable?
}
