//
//  AuthorsTableViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class AuthorsTableViewController: UITableViewController {

    var segment = UISegmentedControl()
    var model: [Dictionary<String, AnyObject>]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        MSAzureStorage.setupAzureClient()
        self.edgesForExtendedLayout = []
        self.title = "Scoops"
        registerNib()
        segment = UISegmentedControl(items: ["Todas", "Publicadas", "No publicadas"])
        segment.addTarget(self, action: #selector(AuthorsTableViewController.switchOrderBy), for: UIControlEvents.valueChanged)
        self.navigationItem.titleView = segment
        
        let addPost = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AuthorsTableViewController.addPost))
        self.navigationItem.rightBarButtonItem = addPost
        
        self.tableView.register(UINib(nibName: "NewTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MSAzureMobile.syncViewWithModel(predicate: nil, withController: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let rows = MSAzureMobile.model?.count {
            return rows
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewTableViewCell.cellID, for: indexPath) as? NewTableViewCell
        
        cell!.titulo.text = MSAzureMobile.model![indexPath.row]["titulo"] as? String
        
        if let val = MSAzureMobile.model![indexPath.row]["valoracion"] as? Int{
            cell!.valoracion.text = String(val)
        } else {
            cell!.valoracion.text = "0"
        }
        
        cell?.autor.text = MSAzureMobile.model![indexPath.row]["autor"] as? String
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let _model = MSAzureMobile.model?[indexPath.row]
        let authorVC = AuthorDetailViewController(model: _model)
        
        self.navigationController?.pushViewController(authorVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Noticias - Autor"
    }
 

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
    
    //MARK: - Cell registration
    
    private func registerNib(){
        let nib = UINib(nibName: "NewTableViewCell", bundle: Bundle.main)
        self.tableView.register(nib, forCellReuseIdentifier: NewTableViewCell.cellID)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewTableViewCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewTableViewCell.cellHeader
    }
    
    //MARK: - Utils
    

    

}

extension AuthorsTableViewController {
    
    func addPost() {
        let newVC = AuthorDetailViewController(model: nil)
        self.navigationController?.pushViewController(newVC, animated: true)
    }
}

extension AuthorsTableViewController {
    
    func readAllItemsInTable() {
        
        MSAzureMobile.client.invokeAPI("readAllRecords", body: nil, httpMethod: "GET", parameters: nil, headers: nil) { (result, respose, error) in
            
            if let _ = error {
                print(error)
                return
            }
            
            if !((self.model?.isEmpty)!) {
                self.model?.removeAll()
            }
            
            if let _ = result {
                
                let json = result as! [PostRecord]
                
                for item in json {
                    self.model?.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }

            }

        }
    }
}

extension AuthorsTableViewController {
    
    func switchOrderBy() {
        
        switch segment.selectedSegmentIndex{
        case 0:
            MSAzureMobile.syncViewWithModel(predicate: nil, withController: self)
        case 1:
            MSAzureMobile.syncViewWithModel(predicate: NSPredicate(format: "publicado = true", argumentArray: nil), withController: self)
        case 2:
            MSAzureMobile.syncViewWithModel(predicate: NSPredicate(format: "publicado = false", argumentArray: nil), withController: self)
        default: break
        }
        
    }
    
}
