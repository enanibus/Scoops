//
//  MSAzureMobile.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class MSAzureMobile: NSObject {
        
    static let MOBILE_SERVICE   = "https://boot3-mbass.azurewebsites.net"
    
    static var client: MSClient = MSClient(applicationURL: URL(string: MOBILE_SERVICE)!)
    
    static var model: [AnyObject]?
    static var posts: MSTable?
    
    class func syncViewWithModel(predicate: NSPredicate?, withController: UITableViewController) {
        
        let posts = MSAzureMobile.client.table(withName: "posts")
        
        let query = MSQuery(table: posts)
        
        if let predicateQuery = predicate {
            query.predicate = predicateQuery
        }
        
        query.order(byAscending: "titulo")
        query.read { (result, error) in
            
            if let _ = error {
                print(error)
            }
            
            model = result?.items as [AnyObject]?
            withController.tableView.reloadData()
        }
    }
}
