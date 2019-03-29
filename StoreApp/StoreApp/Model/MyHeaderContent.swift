//
//  MyHeaderContent.swift
//  StoreApp
//
//  Created by Yoda Codd on 2019. 3. 28..
//  Copyright © 2019년 Drake. All rights reserved.
//

import Foundation

/// 헤더의 타이틀과 텍스트를 가진다
class MyHeaderContent {
    let title : String
    let adCopy : String
    
    init(title: String, text: String){
        self.title = title
        self.adCopy = text
    }
}

/// 헤더컨텐트의 배열을 가진다
class MyHeaderContentManager{
    private var list : [MyHeaderContent] = []
    
    /// myHeaderContent 내용추가
    func add(myHeaderContent: MyHeaderContent){
        self.list.append(myHeaderContent)
    }
    
    /// 인덱스를 받아서 헤더컨텐트 리턴
    subscript(index: Int) -> MyHeaderContent {
        return self.list[index]
    }
}
