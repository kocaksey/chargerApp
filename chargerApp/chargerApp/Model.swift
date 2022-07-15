//
//  Model.swift
//  chargerApp
//
//  Created by Seyhun Koçak on 15.07.2022.
//

import Foundation

struct User: Decodable {
  let email: String?
  let token: String?
  let userID: Int?
}
