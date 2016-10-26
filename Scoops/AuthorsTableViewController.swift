//
//  AuthorsTableViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class AuthorsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = "Posts"
        let addPost = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AuthorsTableViewController.addPost))
        self.navigationItem.rightBarButtonItem = addPost
        
        self.tableView.register(UINib(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AuthorsTableViewController {
    
    func addPost() {
        
        let tableMS = MSAzureMobile.client.table(withName: "Posts")
        
        tableMS.insert(["titulo" : "Post1",
                        "texto" : "texto1",
                        "foto" : "foto1",
                        "latitud" : 1.1,
                        "longitud" : 1.1,
                        "autor" : "Jacobo Uno",
                        "publicado" : false,
                        "valoracion" : 1.1,
                        "paraPublicar" : false,
                        "container" : "container1"
                        ])
        { (result, error) in
            
            if let _ = error {
                print(error)
                return
            }
//            self.readAllItemsInTable()
            print(result)
        }
    }
}



extension AuthorsTableViewController {
    
    func insertPost() {
        
        MSAzureMobile.client.invokeAPI("insertPost", body: ["titulo": "Titulo1", "texto": "texto1"], httpMethod: "POST", parameters: nil, headers: nil) { (result, response, error) in
            
            
            if let _ = error {
                print(error)
                return
            }
            
//            if !((self.model?.isEmpty)!) {
//                self.model?.removeAll()
//            }
            
            if let _ = result {
            
                print(result)
                
//                let json = result as! [AutorRecord]
//                
//                for item in json {
//                    self.model?.append(item)
//                }
//                
//                DispatchQueue.main.async {
//                    
//                    self.tableView.reloadData()
//                }
                
            }
            
        }
        
        
    }
}
