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
    // END-UOC-1
    
    override func viewDidLoad() {
        currentProfile = loadProfile()
    }
    
    // BEGIN-UOC-2
    func saveProfileData(_ currentProfile: Profile) {

    }
    // END-UOC-2
    
    // BEGIN-UOC-3
    func loadProfile() -> Profile {
        return Profile(name: "", surname: "", streetAddress: "", city: "", occupation: "", company: "", income: 0)
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
