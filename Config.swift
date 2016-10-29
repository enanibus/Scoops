//
//  Constants.swift
//  HackerBooks enanibus imported
//
//  Created by Jacobo Enriquez Gabeiras on 30/6/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import Foundation
import UIKit

enum StatusNews: Int{
    case Todas = 0
    case Publicadas = 1
    case SinPublicar = 2
}

public let defaults                             =   UserDefaults.standard
public let NO_IMAGE_AVAILABLE                   =   "no-image-available.png"
public let USER_ID                              =   "userId"
public let MOBILE_SERVICE_AUTH_TOKEN            =   "token"
public let AUTHENTICATION_PROVIDER              =   "facebook"
