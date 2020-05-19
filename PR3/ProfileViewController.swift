//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    var currentProfile: Profile?
    
    // BEGIN-UOC-1
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var incomeField: UITextField!
    
    
    
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
    }
    
    // BEGIN-UOC-2
    
    //Obtiene Obtiene la ruta de la carpeta documentos.
    func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //Prepara el archivo llamado profile_data.plist
    func dataFilePath() -> URL {
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
    // END-UOC-5
    
    // BEGIN-UOC-6
    func loadProfileImage() -> UIImage? {
        return UIImage(named: "EmptyProfile.png")
    }
    
    func saveProfileImage(_ image: UIImage) {
        
    }
    // END-UOC-6
}
