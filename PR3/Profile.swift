//
//  Profile.swift
//  PR3
//
//  Copyright © 2020 UOC. All rights reserved.
//

import Foundation

struct Profile :Codable {
    var name: String
    var surname: String
    var streetAddress: String
    var city: String
    var occupation: String
    var company: String
    var income: Int
}
