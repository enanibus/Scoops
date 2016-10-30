//
//  AuthorDetailViewController.swift
//  Scoops
//
//  Created by Jacobo Enriquez Gabeiras on 25/10/16.
//  Copyright © 2016 enanibus. All rights reserved.
//

import UIKit
import CoreLocation

class AuthorDetailViewController: UIViewController {
    
//    var postSelected: Int?
    var postDraft = [String:String]()
    var blobName : String = "no-image-available.png"
    var imageData : NSData?
    
    var locationManager: CLLocationManager?
    var latitud: Double = 0.0
    var longitud: Double = 0.0
    
    var _model: AnyObject? {
        didSet {
            self.syncViewWithModel()
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
    
    @IBOutlet weak var titulo: UITextField!
    
    @IBOutlet weak var autor: UITextField!
    
    @IBOutlet weak var texto: UITextView!
    
    @IBOutlet weak var valoracion: UILabel!
    
    @IBOutlet weak var foto: UIImageView!
    
    @IBOutlet weak var aniadir: UIBarButtonItem!
    
    @IBOutlet weak var publicar: UIBarButtonItem!
    
    //MARK: - Actions

    @IBAction func addPost(_ sender: AnyObject) {
        let tableMS = MSAzureMobile.client.table(withName: "Posts")
        if self._model == nil {
            // formateo del alta
            self.postDraft = [
                "titulo": self.titulo.text!,
                "autor": self.autor.text!,
                "texto": self.texto.text,
                "foto": self.blobName
            ]
            
//                if error != nil{
//                    print("Tenemos un error -> : \(error)")
//                    self.showMessage("No se ha podido crear la noticia", withTitle: "Error")
//                } else {
//                    
//                    // 2: Persistir el blob en el Storage siempre y cuando haya imagen
//                    if self.myBlobName != "noImage.png" {
//                        FHLAzureCommunication.uploadToStorage(self.myImage!, blobName: self.myBlobName)
//                    }
//                    self.insertedObject = inserted
//                    self.disponible.enabled = true
//                    self.showMessage("Noticia Creada", withTitle: "Información")
//                    
//                }
//            })
            
            tableMS.insert(postDraft) { (result, error) in
                
                if let _ = error {
                    print(error)
                    return
                }
                print(result)
                let _ = self.navigationController?.popViewController(animated: true)
            }

        } else {
            self.postDraft["id"] = self._model?["id"] as! String?
            self.postDraft["autor"] = self.autor.text
            self.postDraft["titulo"] = self.titulo.text
            self.postDraft["texto"] = self.texto.text
            
            tableMS.update(postDraft) { (result, error) in
                
                if let _ = error {
                    print(error)
                    return
                }
                print(result)
                let _ = self.navigationController?.popViewController(animated: true)
            }
        }

    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isCameraDeviceAvailable(.rear){
            picker.sourceType = .camera
        } else{
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        self.present(picker, animated: true){
            
        }
    }
    
    @IBAction func publicar(_ sender: AnyObject) {
        
    }
    
    
    func syncViewWithModel() {
        
        // Titulo
        self.titulo.text = self._model?["titulo"] as? String
        
        // Autor
        self.autor.text = self._model?["autor"] as? String
        
        // Texto
        self.texto.text = self._model?["texto"] as? String
        
        //Valoración
        let valoracion = self._model?["valoracion"] as! NSNumber
        self.valoracion.text = valoracion.description
        
        // Cambiar texto del botón de actualización
        if (self._model == nil) {
            self.aniadir.title = "Añadir"
        }
        else {
            self.aniadir.title = "Modificar"
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (_model != nil) {
            syncViewWithModel()
        }
        else {
            self.foto.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(AuthorDetailViewController.takePhoto(_:)))
            self.foto.addGestureRecognizer(tap)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UIImagePickerControllerDelegate

extension AuthorDetailViewController: UINavigationControllerDelegate{
    
}

extension AuthorDetailViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true){}
        let image = info[UIImagePickerControllerOriginalImage] as!  UIImage?
        if (image != nil){
//           subir la foto a Storage
            imageData = UIImageJPEGRepresentation(image!, 0.9) as NSData?
            self.foto.image = image
            self.blobName = "image-\(NSUUID().uuidString).jpeg"
        }
    }
}

