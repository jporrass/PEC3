//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit
import  AVFoundation

class ProfileViewController: UITableViewController, UITextFieldDelegate{
    var currentProfile: Profile?
    var image: UIImage?
    var observer: Any! // Es usada para decirle al notification Center que ya no envie la notificacion de que la image se va a cerrar.
                       // puede ser que no sea necesario si la app ya no esta en primer plano, u otras razones.
   
    
    // BEGIN-UOC-1
    
      
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var incomeField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    func preSaveData() {
        
        let intInCome = Int(incomeField.text ?? "") ?? 0
           
        let profile = Profile(name: nameField.text!, surname: surnameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!,
                              occupation: occupationField.text!, company: companyField.text!, income: intInCome)
        
        saveProfileData(profile)
        
    }

    @IBAction func saveProfileButton(_ sender: UIButton) {
         
        preSaveData()
        
    }
    
    
    // END-UOC-1
    
    override func viewDidLoad() {
        
    

        currentProfile = loadProfile()
        
        showData(currentProfile: currentProfile!)
             
        nameField.delegate = self
        surnameField.delegate = self
        streetAddressField.delegate = self
        cityField.delegate = self
        occupationField.delegate = self
        companyField.delegate = self
        incomeField.delegate = self
        nameField.becomeFirstResponder()
            
        profileImageView.image = loadProfileImage()
                
    }
    
    // BEGIN-UOC-2
    
    //Obtiene Obtiene la ruta de la carpeta documentos.
    func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
     func imageFilePath() -> URL {
           print (documentsDirectory())
           return documentsDirectory().appendingPathComponent("profile_image")
       }
    
    //Prepara el archivo llamado profile_data.plist
    func dataFilePath() -> URL {
        print (documentsDirectory())
        return documentsDirectory().appendingPathComponent("profile_data.plist")
    }
    //Guarda el archivo en el directorio.
    func saveProfileData(_ currentProfile: Profile) {
        
          let encoder = PropertyListEncoder()
        
          do {
        
            //Se prepara para ser grabado.
            let data = try encoder.encode(currentProfile)
        
            //Se guarda el archivo.
            try data.write(to: dataFilePath(),options: Data.WritingOptions.atomic)
            
            //Intenta salvar la imagen. //PREGUNTA 6
            saveProfileImage(image!)
            
            
          }
          catch
          {
                print("Error saving profile user data.: \(error.localizedDescription)")
           }
    }
    // END-UOC-2
    
    // BEGIN-UOC-3
    func loadProfile() -> Profile {
                   
        //Obtiene la rura del archivo
        let path = dataFilePath()
        
        //Crea un objeto con datos en blanco por si debe devolverlo.
        var profile: Profile?
        profile = Profile(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
        
        if let data = try? Data(contentsOf: path) {
                   
            let decoder = PropertyListDecoder()
            do {
                profile = try? decoder.decode(Profile.self, from: data)
            }
            /*
            catch {
              print("Error decoding item array: \(error.localizedDescription)")
            }
             */
            
        }
        return profile!
        
    }
    
   //Muestra la informacion en los campos de texto.
    func showData(currentProfile: Profile) {
        
        nameField.text = currentProfile.name
        surnameField.text = currentProfile.surname
        streetAddressField.text = currentProfile.streetAddress
        cityField.text = currentProfile.city
        occupationField.text = currentProfile.occupation
        companyField.text = currentProfile.company
        incomeField.text = String(currentProfile.income)
                
    }
 
    // END-UOC-3
    
    // BEGIN-UOC-4

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                        
            switch textField {
            case nameField:
                surnameField.becomeFirstResponder()
            case surnameField:
                streetAddressField.becomeFirstResponder()
            case streetAddressField:
                cityField.becomeFirstResponder()
            case cityField:
                 occupationField.becomeFirstResponder()
            case occupationField:
                companyField.becomeFirstResponder()
            case companyField:
                 incomeField.becomeFirstResponder()
            case incomeField:
                 preSaveData()
            default:
                preSaveData()
            }
          
        return true
    }
    // END-UOC-4
    
    // BEGIN-UOC-5
    
    
    @IBAction func updateProfileImageButton(_ sender: UIButton) {
         
        //takePhotoWithCamera()
        
        //choosePhotoFromLibrary()
        
        pickPhoto()
    }
    
    // END-UOC-5
    
    // BEGIN-UOC-6
    
    func loadProfileImage() -> UIImage? {
        
        
        
        //Obtiene la rura del archivo
        let path = documentsDirectory().appendingPathComponent("profile_image")
        if let data = try? Data(contentsOf: path) {
            image = UIImage(data:data)
            profileImageView.image = image

           profileImageView.layer.cornerRadius = 5.0;
           profileImageView.layer.masksToBounds = true;
         }
             
        circleTheImage()
        
        if image === nil{
         return UIImage(named: "EmptyProfile.png")
        } else {
            return image
        }
        
    }

    func circleTheImage(){
       profileImageView.contentMode = UIView.ContentMode.scaleAspectFill
       profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
       profileImageView.layer.masksToBounds = false
       profileImageView.clipsToBounds = true
    }
    
    
    
    func saveProfileImage(_ image: UIImage) {
        
        if let data = image.jpegData(compressionQuality: 0.5) { // 3
        do {
        try data.write(to: documentsDirectory().appendingPathComponent("profile_image"), options: .atomic)
        } catch {
              print("Error writing file: \(error)")
            }
        }
        
    }
    
    
    // END-UOC-6
    
    
    /*Este metodo es parte de la pregunta 5.
     */
       deinit {
          print("*** deinit \(self)")
            if observer != nil{
               NotificationCenter.default.removeObserver(observer!)
            }
       
            
        }
         
}


extension ProfileViewController:
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{
// MARK:- Image Helper Methods
    func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- Image Picker Delegates
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
    [UIImagePickerController.InfoKey : Any]) {
    image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
      if let theImage = image {
        show(image: theImage)
      }
      dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      dismiss(animated: true, completion: nil)
    }
    
    func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func pickPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
          } else {
            choosePhotoFromLibrary()
          }
    }
    //Permite al usuario elegir entre si tomar una foto o elegir una de la libreria.
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil,preferredStyle: .actionSheet)
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      
        alert.addAction(actCancel)
        
        let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: nil)
        
        alert.addAction(actPhoto)
        
        let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: nil)
        
        alert.addAction(actLibrary)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    //Muestra la imagen.
    func show(image: UIImage) {
        profileImageView.image = image
        profileImageView.isHidden = false
        
    }
    
    //Este metodo funciona con un listener. Cuando se emite una notificacion de que la app se
    //va a cambiar de estado, este metodo se ejecuta.
    //termina lo que esta haciendo un poner el nameField como primer espondedor, para no dejar
    //a medias el proceso de la seleccion o toma de la foto

    
    func listenForBackgroundNotification() {
        observer = NotificationCenter.default.addObserver(
        forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: OperationQueue.main) { [weak self] _ in
            if let weakSelf = self {
                if weakSelf.presentedViewController != nil {
                    weakSelf.dismiss(animated: false, completion: nil)
                }
                weakSelf.nameField.resignFirstResponder()
            }
        }
    }
    
}

//Esta extensi162n se utiliza para hacer la imnagen de forma circular.
extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

   // make square(* must to make circle),
   // resize(reduce the kilobyte) and
   // fix rotation.
   self.image = anyImage
  }
}
