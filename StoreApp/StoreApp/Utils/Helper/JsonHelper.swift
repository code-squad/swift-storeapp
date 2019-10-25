//
//  JsonHelper.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/23.
//  Copyright © 2019 hong3. All rights reserved.
//

import Foundation

//MARK: - JsonHelper
class JsonHelper {
    
    static func loadItem(resource:String,file_type:String) -> [StoreItem]? {
        guard let f_path = Bundle.main.path(forResource: resource, ofType: file_type),
            let data = try? Data(contentsOf: URL(fileURLWithPath: f_path),options: .mappedIfSafe) else { return nil }
        
        // Debug
        print("path :\(f_path)")
        print("data :\(data)")
        
        do {
            return try JSONDecoder().decode([StoreItem].self,from:data)
        }catch {
            print("error : \(error.localizedDescription)")
            return nil
        }
    }
}
