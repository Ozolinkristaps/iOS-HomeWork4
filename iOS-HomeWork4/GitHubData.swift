//
//  GitHubData.swift
//  iOS-HomeWork4
//
//  Created by User on 09/06/2020.
//  Copyright © 2020 Kristaps Ozoliņš. All rights reserved.
//

import Foundation

/// MARK: - Welcome
struct GitHubData: Codable {
    let name, path, sha: String?
    let size: Int?
    let url, htmlURL: String?
    let gitURL: String?
    let downloadURL: String?
    let type: String?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case name, path, sha, size, url
        case htmlURL = "html_url"
        case gitURL = "git_url"
        case downloadURL = "download_url"
        case type
        case links = "_links"
    }
}

// MARK: - Links
struct Links: Codable {
    let linksSelf: String?
    let git: String?
    let html: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case git, html
    }
}
