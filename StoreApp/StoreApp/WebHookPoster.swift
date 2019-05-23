//
//  WebHookPoster.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 5. 23..
//  Copyright © 2019 hngfu. All rights reserved.
//

import Foundation

struct WebHookPoster {
    func post(message: String) {
        let session = URLSession.shared
        guard let url = URL(string: Configuration.URL.webHookURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json = ["text": message]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []) else { return }
        let task = session.uploadTask(with: request, from: jsonData)
        task.resume()
    }
}
