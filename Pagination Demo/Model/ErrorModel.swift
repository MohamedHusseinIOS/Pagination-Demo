//
//  ErrorModel.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

struct ErrorModel: BaseModel {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
    }
}
