//
//  DataLoader.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 3. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit

class DataLoader {
    typealias AfterTask = (LoadedData) -> Void
    private var loadedDataWithSection = LoadedItems(section: .main, data: []) {
        didSet {
            NotificationCenter.default.post(name: .dataLoaded, object: nil,
                                            userInfo: ["loadedItems": loadedDataWithSection])
        }
    }

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loadDataFromServer),
                                               name: .connectionChanged, object: nil)
    }

    func loadInitialData() {
        ReachabilityMonitor.shared.isAvailable ? loadDataFromServer() : loadDataFromLocal()
    }

    private func loadDataFromLocal() {
        loadItemsFromFile(forSection: .main) { self.saveAsDecodedData($0) }
        loadItemsFromFile(forSection: .soup) { self.saveAsDecodedData($0) }
        loadItemsFromFile(forSection: .side) { self.saveAsDecodedData($0) }
    }

    @objc private func loadDataFromServer() {
        loadItemsFromAPI(forSection: .main, from: .remote) { self.saveAsDecodedData($0) }
        loadItemsFromAPI(forSection: .soup, from: .remote) { self.saveAsDecodedData($0) }
        loadItemsFromAPI(forSection: .side, from: .remote) { self.saveAsDecodedData($0) }
    }

    private func loadItemsFromFile(forSection section: TableSection, completion: @escaping AfterTask) {
        guard let data = Downloader.getDataFromJSONFile(section.localFilename) else { return }
        completion(LoadedData(section: section, result: Downloader.Result.success(data)))
    }

    private func loadItemsFromAPI(forSection section: TableSection, from server: Server,
                                  completion: @escaping AfterTask) {
        Downloader.downloadWithDataTask(from: section.api(from: server)) { response in
            completion(LoadedData(section: section, result: response))
        }
    }

    private func saveAsDecodedData(_ loadedData: LoadedData) {
        if case Downloader.Result.success(let data) = loadedData.result {
            guard let decodedData = try? JSONDecoder().decode([StoreItem].self, from: data) else { return }
            self.loadedDataWithSection = LoadedItems.init(section: loadedData.section, data: decodedData)
        }
    }
}

struct LoadedData {
    let section: TableSection
    let result: Downloader.Result
}

struct LoadedItems {
    let section: TableSection
    let data: [StoreItem]
}
