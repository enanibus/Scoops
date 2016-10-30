//
//  MSAzureStorage.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 28/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class MSAzureStorage: NSObject {
    
    static let ACCOUNT_NAME   = "boot3jacobo"
    static let ACCOUNT_KEY    = "XE9YzFYhDayDFvq4oNGsxoWJUc4y+xZWTH1v3Bb3BntZHiJXqOeidF+GexDro6fKd2JYrNCR/J9FeQLPLC+E3w=="
    static let BLOB_ENDPOINT    = "https://boot3jacobo.blob.core.windows.net/"
    
    static var blobClient: AZSCloudBlobClient?
    
    static var blobContainer: AZSCloudBlobContainer?
    
    class func setupAzureClient()  {
        
        do {
            let credentials = AZSStorageCredentials(accountName: ACCOUNT_NAME,
                                                    accountKey: ACCOUNT_KEY)
            let account = try AZSCloudStorageAccount(credentials: credentials, useHttps: true)
            
            blobClient = account.getBlobClient()
            
            blobContainer = blobClient?.containerReference(fromName: "scoops")
            
        } catch let error {
            print(error)
        }
        
    }
}
