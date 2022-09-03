//
//  Petition.swift
//  Project7_Whitehouse Petitions
//
//  Created by Mohamed on 02/09/2022.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
