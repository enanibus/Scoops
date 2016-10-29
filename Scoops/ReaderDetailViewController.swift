//
//  ReaderDetailViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class ReaderDetailViewController: UIViewController {

//    var postSelected: Int?
    
    var _model: AnyObject? {
        didSet {
            self.syncViewWithModel()
        }
    }
    
    @IBOutlet weak var titulo: UILabel!

    @IBOutlet weak var autor: UILabel!
    
    @IBOutlet weak var texto: UITextView!

    @IBOutlet weak var valoracion: UIBarButtonItem!
    
    //MARK: - Initialization
    init(model: AnyObject?){
        self._model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions
    
    @IBAction func meGusta(_ sender: AnyObject) {
    }
    
    func syncViewWithModel(){
        
        // Titulo
        self.titulo.text = _model?["titulo"] as? String
        
        // Autor
        self.autor.text = _model?["autor"] as? String
        
        // Texto
        self.texto.text = _model?["texto"] as? String
        
        
        
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

}
