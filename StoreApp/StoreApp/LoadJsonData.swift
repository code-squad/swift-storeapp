//
//  LoadJsonData.swift
//  StoreApp
//
//  Created by Hongdonghyun on 2019/10/23.
//  Copyright © 2019 hong3. All rights reserved.
//

import Foundation

class JsonHelper {
    static func loadItem() -> [StoreItem]? {
        guard let f_path = Bundle.main.path(forResource: "main_item", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: f_path),options: .mappedIfSafe) else { return nil }
        
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
