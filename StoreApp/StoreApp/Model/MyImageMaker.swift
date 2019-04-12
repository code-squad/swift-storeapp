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
    private var savedURLsList : [[String]] = []
    
    // Create destination URL
    let folderUrl: URL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first as URL!
    
    /// 리로드 완료된 섹션 카운트 + 1
    func addFinishedCount(){
        self.finishedSectionCount += 1
    }
    
    /// 섹션 카운트 초기값 선언
    func setMaxSectionCount(count: Int){
        self.maxSectionCount = count
        
        // 맥스값만큼 빈 url 배열을 추가해준다
        for _ in 0..<count {
            self.savedURLsList.append([])
        }
    }
    
    /// url 배열을 지정해서 저장한다
    private func saveURLList(section: Int){
        // 가독성을 위해 작업할 url 배열을 변수로 선언
        let savedURLs = self.savedURLsList[section]
        
        // 모든 url배열을 파일들로 저장한다
        for count in 0..<savedURLs.count {
            save(imageURL: savedURLs[count], section: section, row: count)
        }
    }
    
    /// 모든 섹션이 추가되면 파일저장을 시작한다
    private func saveAllURL(){
        // url 배열을 추출
        for savedURLsListCount in 0..<self.savedURLsList.count {
            // url배열을 파일들로 저장한다
            saveURLList(section: savedURLsListCount)
        }
    }
    
    /// 섹션인덱스와 url 배열을 받아서 저장한다
    func getURLs(section: Int, urls: [String]){
        // 완료 추가한다
        self.addFinishedCount()
        
        // url 입력
        self.savedURLsList[section] = urls
        
        // 모든 섹션이 추가되면 파일을 저장한다
        if self.maxSectionCount == self.finishedSectionCount {
            // url 배열을 추출
            saveAllURL()
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
    
    private func save(imageURL: String, section: Int, row: Int){
        // 시작 로깅
        os_log("url 다운로드 시도 : %@",imageURL)
        
        // 파일명 추출
        guard let fileName = extractFileNameFrom(imageURL: imageURL) else {
            return ()
        }
        
        // Create destination URL
        let documentsUrl: URL =  self.folderUrl
        let destinationFileUrl = documentsUrl.appendingPathComponent(fileName)
        
        //Create URL to the source file you want to download
        guard let fileURL = URL(string: imageURL) else {
            os_log("입력된 파일url을 URL 형으로 변환하지 못했습니다. fileURL : %@", imageURL)
            return ()
        }
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:fileURL)
        
        // downloadTask 시작
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // 연결 시도가 성공한다면
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    // 로깅용 형변환
                    let statusCodeString = String(statusCode)
                    // 연결 성공 로깅
                    os_log("Successfully downloaded. Status code: %@",statusCodeString)
                }
                // 파일 다운로드 복사 작업 시작
                do {
                    // 같은이름의 파일이 있다면 받지 않는다.
                    if FileManager.default.fileExists(atPath: destinationFileUrl.path) {
                        os_log("기존파일 존재. 다운로드 패스 : %@", fileName)
                    } // 없다면 새 파일 다운로드
                    else {
                        // 다운로드 시도
                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                        os_log("다운로드 성공 : %@", fileName)
                    }
                    
                    // 다운로드 성공 노티를 위한 인포 작성
                    let userInfo: [String : Any] = ["fileName" : destinationFileUrl.path, "section" : section, "row" : row]
                    
                    // 다운로드 성공 노티 포스트
                    NotificationCenter.default.post(name: .didDownloadImageFile, object: self, userInfo: userInfo)
                    
                } // 파일복사 작업 실패시
                catch (let writeError) {
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
                // 웹 연결 실패시
            } else {
                os_log("Error took place while downloading a file. Error description: %@", (error?.localizedDescription)!);
            }
        }
        task.resume()
    }
    
}

