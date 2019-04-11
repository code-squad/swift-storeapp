//
//  ImageMaker.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 4. 9..
//  Copyright © 2019년 Drake. All rights reserved.
//

import UIKit
import os

class MyImageMaker {
    /// 섹션 카운트
    private var maxSectionCount = 0
    
    /// 리로드 완료된 섹션 카운트
    private var finishedSectionCount = 0
    
    /// url 배열들
    private var urls : [[String]] = []
    
    /// 이미지 배열들
    private var images : [[UIImage]] = []
    
    /// 리로드 완료된 섹션 카운트 + 1
    func addFinishedCount(){
        self.finishedSectionCount += 1
    }
    
    /// 섹션 카운트 초기값 선언
    func setMaxSectionCount(count: Int){
        self.maxSectionCount = count
        
        // 맥스값만큼 빈 url 배열을 추가해준다
        for _ in 0..<count {
            self.urls.append([])
            self.images.append([])
        }
    }
    
    /// 섹션인덱스와 url 배열을 받아서 저장한다
    func getURLs(section: Int, urls: [String]){
        // 완료 추가한다
        self.addFinishedCount()
        
        // url 입력
        self.urls[section] = urls
        
        // 파일들을 저장한다
        for url in urls {
            save(imageURL: url)
        }
    }
    
    /// image url 을 받아서 파일명만 리턴 : 마지막 / 뒤만 리턴
    private func extractFileNameFrom(imageURL: String) -> String? {
        // url 에서 마지막 / 인덱스를 추출
        guard let lastIndex = imageURL.range(of: "/", options: .backwards)?.lowerBound else {
            return nil
        }
        
        // 마지막 / 이후를 추출해야함. / 한칸 뒤 인덱스 추출
        let nextLastIndex = imageURL.index(after: lastIndex)
        
        // 마지막 인덱스 이후의 범위를 부분문자열로 추출
        let fileNameSubString = imageURL[nextLastIndex...]
        
        // 부분문자열을 완전한 문자열로 추출
        let fileName = String(fileNameSubString)
        
        // 리턴
        return fileName
    }
    
    func save(imageURL: String){
        // 시작 로깅
        os_log("url 다운로드 시도 : %@",imageURL)
        
        // 파일명 추출
        guard let fileName = extractFileNameFrom(imageURL: imageURL) else {
            return ()
        }
        
        // Create destination URL
        let documentsUrl: URL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first as URL!
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: imageURL)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    os_log("다운로드 성공 : %@", fileName)
                } catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
            }
        }
        task.resume()
    }
    
}

