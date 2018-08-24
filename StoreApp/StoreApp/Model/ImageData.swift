//
//  ImageData.swift
//  StoreApp
//
//  Created by 김수현 on 2018. 8. 24..
//  Copyright © 2018년 김수현. All rights reserved.
//

import Foundation

struct ImageData {
    
    func fetchItemImages(_ imageURL: String) -> Data? {
        guard let fileURL = makeImageURL(imageURL) else { return nil }
        if FileManager.default.fileExists(atPath: fileURL.path) {
            guard let data = loadImageData(fileURL) else { return nil }
            return data
        } else { //파일이 없을경우 파일 생성후 데이터 저장
            DispatchQueue.global().async {
                guard let data = self.saveImageData(imageURL, fileURL) else { return }
                DispatchQueue.main.async {
                    return data
                }
            }
            return nil
        }
    }
    
    private func makeImageURL(_ imageURL: String) -> URL? {
        
        //urls(for:in:) 메소드를 통해 특정 경로에 접근한 후 추가 경로를 cachesDirectory로 지정
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
        
        guard let url = URL(string: imageURL) else { return nil }
        
        //imageURL에서 경로 /구분자를 이용해 문자열을 분리한 후 마지막 문자열을 기존의 경로에 추가
        let fileURL = path.appendingPathComponent(url.lastPathComponent)
        
        return fileURL
    }
    
    private func loadImageData(_ url: URL) -> Data? {
        return FileManager.default.contents(atPath: url.path)
    }
    
    private func saveImageData(_ imageURL: String,_ fileURL: URL) -> Data? {
        guard let url = URL(string: imageURL) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        FileManager.default.createFile(atPath: fileURL.path, contents: data, attributes: nil)
        return data
    }
    
}
