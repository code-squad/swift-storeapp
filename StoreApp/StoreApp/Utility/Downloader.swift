//
//  Downloader.swift
//  StoreApp
//
//  Created by 권재욱 on 2018. 5. 23..
//  Copyright © 2018년 권재욱. All rights reserved.
//

import Foundation

class Downloader {
    
    typealias completionHandler = (Result) -> Void
    typealias errorHandler = (Bool) -> Void
    
    enum Result {
        case success(Data)
        case failure()
    }
    
    static func loadMenuImage(_ menuImageURL: String, completion: @escaping completionHandler) {
        DispatchQueue.global().async {
            guard let fileURL = generateFileURL(menuImageURL) else { return }
            if let data = getImageData(menuImageURL, fileURL) {
                completion(.success(data))
            } else {
                completion(.failure())
            }
        }
    }
    
    static func getImageData(_ menuImageURL: String, _ fileURL: URL) -> Data? {
        guard isExistantFileAt(fileURL) else { return saveData(menuImageURL, fileURL) }
        return loadData(fileURL)
    }
    
    static func generateFileURL(_ imageURL: String) -> URL? {
        guard let documentDirectoryPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        guard let imageURL = URL(string: imageURL) else { return nil }
        return documentDirectoryPath.appendingPathComponent(imageURL.lastPathComponent)
    }
    
    static func isExistantFileAt(_ fileURL: URL) -> Bool {
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    static func loadData(_ fileURL: URL) -> Data? {
        return FileManager.default.contents(atPath: fileURL.path)
    }
    
    static func saveData(_ menuImageURL: String, _ fileURL: URL) -> Data? {
        guard let imageURL = URL(string: menuImageURL) else { return nil }
        guard let data = try? Data(contentsOf: imageURL) else { return nil }
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        return data
    }
    
}
