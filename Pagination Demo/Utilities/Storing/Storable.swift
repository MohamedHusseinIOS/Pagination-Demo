//
//  Storable.swift
//  Pagination Demo
//
//  Created by Mohamed Hussien on 8/29/19.
//  Copyright © 2019 HNF. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T, Error>) -> Void

protocol ReadableStorage {
    func fetchValue(for key: String) throws -> Data
    func fetchValue(for key: String, handler: @escaping Handler<Data>)
}

protocol WritableStorage {
    func save(value: Data, for key: String) throws
    func save(value: Data, for key: String, handler: @escaping Handler<Data>)
}

typealias Storage = ReadableStorage & WritableStorage

enum StorageError: Error {
    case notFound
    case cantWrite(Error)
}
