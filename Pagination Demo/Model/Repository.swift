//
//  Reposatory.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

protocol BaseModel: Codable, Decoderable {}

struct Repository: BaseModel {
    
    let fullName : String?
    let url : String?
    let watchers : Int?
    let watchersCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case fullName
        case url
        case watchers
        case watchersCount
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
