//
//  ReaderDetailViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class ReaderDetailViewController: UIViewController {

    var postSelected: Int?
    
//    var model : PostRecord{
//        didSet {
//            self.syncViewWithModel()
//        }
//    }
    
//    var model: [AnyObject]?
    
    @IBOutlet weak var titulo: UILabel!

    @IBOutlet weak var autor: UILabel!
    
    @IBOutlet weak var texto: UITextView!

    @IBOutlet weak var valoracion: UIBarButtonItem!
    
    //MARK: - Initialization
    

    //MARK: - Actions
    
    func syncViewWithModel(){
        
        // Titulo
        self.titulo.text = MSAzureMobile.model![postSelected!]["titulo"] as? String
        
        // Autor
        self.autor.text = MSAzureMobile.model![postSelected!]["autor"] as? String
        // Texto
        self.texto.text = MSAzureMobile.model![postSelected!]["texto"] as? String
        
//        if (self.model.valoracion == true) {
//            self.favorites.title = "🌟"
//        }else{
//            self.favorites.title = "⭐️"
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        syncViewWithModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncViewWithModel()
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
