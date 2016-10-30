//
//  ReaderDetailViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit

class ReaderDetailViewController: UIViewController {
    
    var blobName : String = "no-image-available.png"
    var imageData : NSData?
    
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
    
    @IBOutlet weak var foto: UIImageView!
    
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
        
        //Foto
        self.getImage()
        
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

// MARK: - Gestión de imagen y storage

extension ReaderDetailViewController {
    
    func uploadBlob(_ image: UIImage) {
        
        // crear el blob local
        self.blobName = UUID().uuidString
        let myBlob = MSAzureStorage.blobContainer?.blockBlobReference(fromName: self.blobName)
        
        // subir
        myBlob?.upload(from: UIImageJPEGRepresentation(image, 0.5)!, completionHandler: { (error) in
            
            if (error != nil) {
                print(error)
                return
            }
            
        })
        
    }
    
    func getImage()  {
        let foto = self._model?["foto"] as? String
        if foto != nil{
            if !((foto?.isEmpty)!){
                
                let myBlob = AZSCloudBlockBlob(container: MSAzureStorage.blobContainer!, name: foto!)
                
                myBlob.downloadToData(completionHandler: { (error, data) in
                    if let _ = error {
                        print(error)
                        return
                    }
                    if let _ = data {
                        let img = UIImage(data: data!)
                        DispatchQueue.main.async {
                            let resIm = img?.resizeWith(width: self.foto.bounds.height)
                            self.foto.image = resIm
                        }
                    }
                })
            }
        }
    }
    
}

