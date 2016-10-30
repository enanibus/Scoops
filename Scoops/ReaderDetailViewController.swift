//
//  ReaderDetailViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class ReaderDetailViewController: UIViewController {
    
    var _model: AnyObject? {
        didSet {
            self.syncViewWithModel()
        }
    }
    
    @IBOutlet weak var titulo: UILabel!

    @IBOutlet weak var autor: UILabel!
    
    @IBOutlet weak var texto: UITextView!

    @IBOutlet weak var valoracion: UILabel!
    
    @IBOutlet weak var numOfVals: UILabel!

    @IBOutlet weak var valor: UILabel!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBAction func cambiarValor(_ sender: UIStepper) {
        let value: Int = Int(sender.value)
        self.valor.text = value.description
    }
    
    @IBAction func valorar(_ sender: AnyObject) {
        var params = Dictionary<String,String>()
        
        params = ["id" : self._model?["id"] as! String,
                  "valoracion" : self.valor.text!]
        
        MSAzureMobile.client.invokeAPI("valorar", body: nil, httpMethod: "PUT", parameters: params, headers: nil) { (data, result, error) in
            
            if let _ = error {
                print (error)
            } else{
                print(data)
                
                DispatchQueue.main.async {
                    self.syncViewWithModel()
                }
            }
        }
    }

    //MARK: - Initialization
    init(model: AnyObject?){
        self._model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Actions
    
    func syncViewWithModel(){
        
        // Titulo
        self.titulo.text = self._model?["titulo"] as? String
        
        // Autor
        self.autor.text = self._model?["autor"] as? String
        
        // Texto
        self.texto.text = self._model?["texto"] as? String
        
        //Valoración
        let valoracion = self._model?["valoracion"] as! NSNumber
        self.valoracion.text = valoracion.description
        
        // Valoraciones
        let numOfVals = self._model?["numOfVals"] as? NSInteger
        self.numOfVals.text = numOfVals?.description
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stepper.minimumValue = 0
        self.stepper.maximumValue = 10
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
