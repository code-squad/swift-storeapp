//  StoreModel.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 12/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import UIKit
import Foundation

// # MARK - Model

class StoreModel {
    
    struct Constant {
        static let baseURL: String = "http://crong.codesquad.kr:8080/woowa/"
        static let mainURL: String = "main"
        static let soupURL: String = "soup"
        static let sideURL: String = "side"
    }
    
    private let sectionInfos: Array<Dictionary<String, String>> = [
        [
            "section_path": Constant.mainURL,
            "section_subtitle": "메인반찬",
            "section_title": "한그릇 뚝딱 메인 요리"
        ], [
            "section_path": Constant.soupURL,
            "section_subtitle": "국.찌게",
            "section_title": "김이 모락모락 국.찌게"
        ], [
            "section_path": Constant.sideURL,
            "section_subtitle": "밑반찬",
            "section_title": "언제 먹어도 든든한 밑반찬"
        ]
    ]
    
    var mySections: Array<StoreSection> = []
    
    func loadData(loadFromNetwork: Bool, completion: @escaping ()->(), fail: @escaping (Error?)->()) {
        mySections = sectionInfos.map { sectionInfo in
            guard let sectionPath = sectionInfo["section_path"],
                let sectionTitle = sectionInfo["section_title"],
                let sectionSubtitle = sectionInfo["section_subtitle"] else {
                    return nil
            }
            let mySection = StoreSection(title: sectionTitle, subtitle: sectionSubtitle, path: sectionPath, items: [])
            return mySection
        }.compactMap{ $0 }
        
        mySections.forEach { mySection in
            if loadFromNetwork {
                let url = Constant.baseURL + mySection.path
                self.loadData(from: url) { (productItems, e)  in
                    guard let productItems = productItems else { fail(e); return; }
                    mySection.myitems = productItems
                    completion()
                }
            } else {
                self.loadData(forResource: mySection.path, ofType:"json") { (productItems, e)  in
                    guard let productItems = productItems else { fail(e); return; }
                    mySection.myitems = productItems
                    completion()
                }
            }
        }
    }
    
    private func loadData(from url: String, completion: @escaping ([StoreItem]?, Error?)->()) {
        guard let url = URL(string: url) else { completion(nil, nil); return }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with:url) { (data, response, error) in
            guard let data = data else { completion(nil, nil); return }
            do {
                let productItems: [StoreItem] = try self.loadData(from: data as Data)
                completion(productItems, nil)
            } catch let e {
                completion(nil, e)
            }
        }.resume()
    }
    
    private func loadData(forResource: String, ofType: String, completion: @escaping ([StoreItem]?, Error?)->()) {
        // main.json 불러와서 파싱
        if let filePath = Bundle.main.path(forResource: forResource, ofType: ofType),
            let data = NSData(contentsOfFile: filePath) {
            do {
                let productItems: [StoreItem] = try self.loadData(from: data as Data)
                completion(productItems, nil)
            } catch let e {
                completion(nil, e)
            }
        } else {
            completion(nil, nil)
        }
    }
    
    private func loadData(from data: Data) throws -> [StoreItem] {
        let decoder = JSONDecoder()
        let productItems: [StoreItem] = try decoder.decode([StoreItem].self, from: data as Data)
        return productItems
    }
    
    var count: Int {
        return mySections.count
    }
    
    func itemCount(section: Int) -> Int {
        guard 0 <= section && section < count else {
            return 0
        }
        return mySections[section].count
    }
    
    func section(with section: Int) -> StoreSection? {
        guard 0 <= section && section < count else {
            return nil
        }
        return mySections[section]
    }
    func item(with section: Int, with row: Int) -> StoreItem? {
        guard 0 <= section && section < count else {
            return nil
        }
        return mySections[section].item(with: row)
    }
}

class StoreSection {
    
    private(set) var title: String
    private(set) var subtitle: String
    let path: String
    var myitems: Array<StoreItem> = []
    
    init(title: String, subtitle: String, path: String, items: Array<StoreItem>) {
        self.myitems = items
        self.title = title
        self.path = path
        self.subtitle = subtitle
    }
    
    var count: Int {
        return myitems.count
    }
    
    func item(with index: Int) -> StoreItem? {
        guard 0 <= index && index < count else {
            return nil
        }
        return myitems[index]
    }
}

struct StoreItem {
    let alt: String
    let delivery_type: [String]
    let description: String
    let detail_hash: String
    let image: String
    let s_price: String
    let title: String
    
    func loadImage(completion: @escaping (UIImage?, String)->()) {
        guard let url = URL(string: image) else { completion(nil, self.image); return; }
        if let imageFromCache = CacheManager.shared.object(forKey: url as AnyObject) as? UIImage {
            completion(imageFromCache, self.image)
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error { print(error); return }
                DispatchQueue.main.async(execute: {
                    if let unwrappedData = data,
                        let imageToCache = UIImage(data: unwrappedData) {
                        CacheManager.shared.setObject(imageToCache, forKey: url as AnyObject)
                        completion(imageToCache, self.image)
                    }
                })
            }).resume()
        }
    }
}

extension StoreItem: Decodable { }

class CacheManager: NSCache<AnyObject, AnyObject> {
    static let shared = CacheManager()
}
