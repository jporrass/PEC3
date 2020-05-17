//
//  ProfileViewController.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var currentProfile: Profile?
    
    // BEGIN-UOC-1
    
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var streetAddressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var occupationField: UITextField!
    @IBOutlet weak var companyField: UITextField!
    @IBOutlet weak var incomeField: UITextField!
    
    

    @IBAction func saveProfileButton(_ sender: UIButton) {
         
        let intInCome = Int(incomeField.text ?? "") ?? 0
           
        let profile = Profile(name: nameField.text!, surname: surnameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!,
                              occupation: occupationField.text!, company: companyField.text!, income: intInCome)
        
        saveProfileData(profile)
        
    }
    
    
    // END-UOC-1
    
    override func viewDidLoad() {
        currentProfile = loadProfile()
        
        showData(currentProfile: currentProfile!)
        
    }
    
    // BEGIN-UOC-2
    //Obtiene el path para guardar el archico
    /*
    func documentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] .appendingPathComponent("profile_data")
        return path
    }
    */
    
    //Obtiene Obtiene la ruta de la carpeta documentos.
    func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    //Prepara el archivo llamado profile_data.plist
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("profile_data.plist")
    }
    
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
        
        //let profile = Profile(name: nameField.text!, surname: surnameField.text!, streetAddress: streetAddressField.text!, city: cityField.text!,
        //occupation: occupationField.text!, company: companyField.text!, income: intInCome)
        
        
         // 1
          let path = dataFilePath()
          // 2
          print ("El path obtenido es: \(path)")
        
        var profile: Profile?
        profile = Profile(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
        
          if let data = try? Data(contentsOf: path) {
        // 3
            
            let decoder = PropertyListDecoder()
            do {
                profile = try? decoder.decode(Profile.self, from: data)
                
            } catch {
              print("Error decoding item array: \(error.localizedDescription)")
            }
            
        }
        return profile!
        
    }
    
   
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
