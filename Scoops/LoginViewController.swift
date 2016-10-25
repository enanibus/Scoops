//
//  LoginViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAuthors(_ sender: AnyObject) {
        
        if isUserLogged() {
            
            if let userLogged = getCredentialsFromDefaults() {
                
                MSAzureMobile.client.currentUser = MSUser(userId: userLogged.userId)
                MSAzureMobile.client.currentUser?.mobileServiceAuthenticationToken = userLogged.token
                
                let authorsVC = AuthorsTableViewController()
                self.navigationController?.pushViewController(authorsVC, animated: true)
            }

            
        } else {
            
            MSAzureMobile.client.login(withProvider: AUTHENTICATION_PROVIDER,
                                       controller: self,
                                       animated: true, completion: { (user, error) in
                                        
                                        if let _ = error {
                                            print(error)
                                            return
                                        }
                                        
                                        if let _ = user {
                                            addCredentialsToDefaults(withCurrentUser: user)
                                            let authorsVC = AuthorsTableViewController()
                                            self.navigationController?.pushViewController(authorsVC, animated: true)
                                        }
            })

        }
        
    }
    
    @IBAction func loginReaders(_ sender: AnyObject) {
        
        if isUserLogged() {
            
            if let userLogged = getCredentialsFromDefaults() {
                
                MSAzureMobile.client.currentUser = MSUser(userId: userLogged.userId)
                MSAzureMobile.client.currentUser?.mobileServiceAuthenticationToken = userLogged.token
                
                let readersVC = AuthorsTableViewController()
                self.navigationController?.pushViewController(readersVC, animated: true)
            }
            
            
        } else {
            
            MSAzureMobile.client.login(withProvider: AUTHENTICATION_PROVIDER,
                                       controller: self,
                                       animated: true, completion: { (user, error) in
                                        
                                        if let _ = error {
                                            print(error)
                                            return
                                        }
                                        
                                        if let _ = user {
                                            addCredentialsToDefaults(withCurrentUser: user)
                                            let readersVC = AuthorsTableViewController()
                                            self.navigationController?.pushViewController(readersVC, animated: true)
                                        }
            })
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
