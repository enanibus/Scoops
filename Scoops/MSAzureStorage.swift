//
//  MSAzureStorage.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 28/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class MSAzureStorage: NSObject {
    
    public static let ACCOUNT_NAME   = "boot3jacobo"
    public static let ACCOUNT_KEY    = "CfXq7PIAWz+XwaqnuNvLcfPUjTQaGBjuW/D6rntMXMcke2rNuL4qp8v4Wpg/R+ajaPpggPFpTpH3ORSsDrslLA=="

    static let BLOB_ENDPOINT    = "https://boot3jacobo.blob.core.windows.net/"
    
    static var blobClient: AZSCloudBlobClient?
    
    static var blobContainer: AZSCloudBlobContainer?
    
    class func setupAzureClient()  {
        
        do {
            let credentials = AZSStorageCredentials(accountName: ACCOUNT_NAME,
                                                    accountKey: ACCOUNT_KEY)
            let account = try AZSCloudStorageAccount(credentials: credentials, useHttps: true)
            
            blobClient = account.getBlobClient()
            
            blobContainer = blobClient?.containerReference(fromName: "posts")
            
        } catch let error {
            print(error)
        }
        
    }
}
