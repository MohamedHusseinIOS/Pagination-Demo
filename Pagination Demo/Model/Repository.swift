//
//  Reposatory.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

protocol BaseModel: Codable, Decoderable {}

struct Repositories: BaseModel {
    
    let repositories: [Repository]?
    
    enum CodingKeys: String, CodingKey {
        case repositories
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(repositories.self, forKey: .repositories)
    }
}

struct Repository: BaseModel {
    
    let fullName: String?
    let description: String?
    let url: String?
    let htmlUrl: String?
    let watchers: Int?
    let forks: Int?
    
    enum CodingKeys: String, CodingKey {
        case fullName
        case description
        case htmlUrl
        case url
        case watchers
        case forks
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(fullName, forKey: .fullName)
        try container.encode(description, forKey: .description)
        try container.encode(url, forKey: .url)
        try container.encode(htmlUrl, forKey: .htmlUrl)
        try container.encode(watchers, forKey: .watchers)
        try container.encode(forks, forKey: .forks)
    }
}

struct RepositoryOwner : Codable, Decoderable {
    
    let avatarUrl : String?
    let login : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl
        case login
        case url
    }
}
