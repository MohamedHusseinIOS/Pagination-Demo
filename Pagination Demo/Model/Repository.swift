//
//  Reposatory.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

protocol BaseModel: Codable, Decoderable {}

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
