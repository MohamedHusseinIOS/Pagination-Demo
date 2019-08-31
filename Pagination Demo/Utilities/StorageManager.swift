//
//  AppUtility.swift
//  Pagination Demo
//
//  Created by Mohamed Hussien on 8/29/19.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    
    private var path: URL
    private var disk: DiskStorage
    private var storage: CodableStorage
    
    private init() {
        path = URL(fileURLWithPath: NSTemporaryDirectory())
        disk = DiskStorage(path: path)
        storage = CodableStorage(storage: disk)
    }
    
    func saveData<T: Codable>(data: T, for key: Stored) throws {
        try storage.save(data, for: key.rawValue)
    }
    
    func fetchData<T: Codable>(for key: Stored) throws -> T {
        return try storage.fetch(for: key.rawValue)
    }
}
