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
            self.postDraft["foto"] = self.blobName
            
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
        let tableMS = MSAzureMobile.client.table(withName: "Posts")
        let publicado = self._model?["publicado"] as! Bool
        let paraPublicar = self._model?["paraPublicar"] as! Bool
        
        self.postDraft["id"] = self._model?["id"] as! String?
        
        if (paraPublicar || publicado == true) {
            self.postDraft["paraPublicar"] = "0"
        } else{
            self.postDraft["paraPublicar"] = "1"
        }
        
        tableMS.update(postDraft) { (result, error) in
            
            if let _ = error {
                print(error)
                return
            }
            print(result)
            let _ = self.navigationController?.popViewController(animated: true)
        }
        
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
        
        //Foto
        self.getImage()
        
        // Cambiar texto del botón de actualización
        if (self._model == nil) {
            self.aniadir.title = "Añadir"
        }
        else {
            self.aniadir.title = "Modificar"
        }
        
        // Cambiar texto de publicación despublicación en el backend
        let publicado = self._model?["publicado"] as! Bool
        let paraPublicar = self._model?["paraPublicar"] as! Bool
        
        if (paraPublicar || publicado == true) {
            self.publicar.title="No publicar"
        }else{
            self.publicar.title="Publicar"
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
        self.getImage()
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
            imageData = UIImageJPEGRepresentation(image!, 0.9) as NSData?
            self.foto.image = image
            uploadBlob(image!)
        }
    }
}

// MARK: - Gestión de imagen y storage

extension AuthorDetailViewController {
    
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

