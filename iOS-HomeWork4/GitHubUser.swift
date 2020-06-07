//
//  GitHubUser.swift
//  iOS-HomeWork4
//
//  Created by User on 07/06/2020.
//  Copyright © 2020 Kristaps Ozoliņš. All rights reserved.
//

import Foundation

// MARK: - GitHubUser
struct GitHubUser: Codable {
    let avatarURL: String?
    let name, company, bio: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case name, company, bio
    }
}
