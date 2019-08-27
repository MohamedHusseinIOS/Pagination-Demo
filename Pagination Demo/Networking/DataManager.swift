//
//  DataManager.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    private init(){}
    
    func handelResponseData<T: BaseModel>( response: ResponseEnum, model: T.Type, completion: @escaping NetworkManager.responseCallback){
        switch response {
        case .success(let value):
            guard let value = value else { return }
            let responseData = model.decodeJSON(value, To: model, format: .convertFromSnakeCase)
            completion(.success(responseData))
        case .failure(let error, let data):
            completion(.failure(error, data))
        }
    }
    
    func getRepositories(page: Int, completion: @escaping NetworkManager.responseCallback){
        let url = "https://api.github.com/users/JakeWharton/repos?page=\(page)&per_page=15"
        NetworkManager.shared.get(url: url) { [unowned self] (response) in
            self.handelResponseData(response: response, model: Repository.self, completion: completion)
        }
    }
}
