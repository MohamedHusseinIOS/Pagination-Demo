//
//  CodableStorage.swift
//  Pagination Demo
//
//  Created by Mohamed Hussien on 8/29/19.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

class CodableStorage {
    private let storage: DiskStorage
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(storage: DiskStorage, decoder: JSONDecoder = .init(), encoder: JSONEncoder = .init()) {
       
        self.storage = storage
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func fetch<T: Decodable>(for key: String) throws -> T {
        let data = try storage.fetchValue(for: key)
        let model = try decoder.decode(T.self, from: data)
        return model
    }
    
    func save<T: Encodable>(_ value: T, for key: String) throws {
        let data = try encoder.encode(value)
        try storage.save(value: data, for: key)
    }
}
