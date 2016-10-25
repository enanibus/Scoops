//
//  Defaults.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import Foundation

enum Directories{
    case Documents
    case Cache
}

//MARK: - UserDefaults & User management

func setDefaults(){
    defaults.set(nil, forKey: USER_ID)
    defaults.set(nil, forKey: MOBILE_SERVICE_AUTH_TOKEN)
    defaults.synchronize()
}

func getCredentialsFromDefaults() -> (userId: String, token: String)? {
    let userId = defaults.object(forKey: USER_ID) as? String
    let token = defaults.object(forKey: MOBILE_SERVICE_AUTH_TOKEN) as? String
    return (userId!, token!)
}

func addCredentialsToDefaults(withCurrentUser user: MSUser?) {
    defaults.set(user?.userId, forKey: USER_ID)
    defaults.set(user?.mobileServiceAuthenticationToken, forKey: MOBILE_SERVICE_AUTH_TOKEN)
}

func isUserLogged() -> Bool {
    if let _ = defaults.object(forKey: USER_ID) as? String {
        return true
    }
    return false
}


