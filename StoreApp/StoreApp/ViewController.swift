//
//  ViewController.swift
//  StoreApp
//
//  Created by 윤동민 on 10/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import UIKit

extension NSNotification.Name {
    static let getMain = NSNotification.Name("getMain")
    static let getSoup = NSNotification.Name("getSoup")
    static let getSide = NSNotification.Name("getSide")
    static let networkingError = NSNotification.Name("networkingError")
    static let parsingError = NSNotification.Name("parsingError")
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var storeItems = StoreItems()
    private lazy var storeAppDataSource = StoreTableViewDataSource(storeItems)
    private lazy var storeAppDelegate = StoreTableViewDelegate(storeItems)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registReloadObserver()
        registErrorObserver()
        storeItems.getDataFromNetwork()
        tableView.delegate = storeAppDelegate
        tableView.dataSource = storeAppDataSource
    }
}

extension ViewController {
    private func registReloadObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMainSection), name: .setMain, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSoupSection), name: .setSoup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSideSection), name: .setSide, object: nil)
    }
    
    @objc func reloadMainSection(notification: NSNotification) {
        guard let itemCount = notification.userInfo?["count"] as? Int else { return }
        var indexPaths: [IndexPath] = []
        for index in 0..<itemCount {
            indexPaths.append(IndexPath(row: index, section: SectionTheme.main.rawValue))
        }
        DispatchQueue.main.sync {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    @objc func reloadSoupSection(notification: NSNotification) {
        guard let itemCount = notification.userInfo?["count"] as? Int else { return }
        var indexPaths: [IndexPath] = []
        for index in 0..<itemCount {
            indexPaths.append(IndexPath(row: index, section: SectionTheme.soup.rawValue))
        }
        DispatchQueue.main.sync {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    @objc func reloadSideSection(notification: NSNotification) {
        guard let itemCount = notification.userInfo?["count"] as? Int else { return }
        var indexPaths: [IndexPath] = []
        for index in 0..<itemCount {
            indexPaths.append(IndexPath(row: index, section: SectionTheme.side.rawValue))
        }
        DispatchQueue.main.sync {
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: indexPaths, with: .automatic)
            self.tableView.endUpdates()
        }
    }
}

extension ViewController {
    private func registErrorObserver () {
        NotificationCenter.default.addObserver(self, selector: #selector(appearNetworkingError), name: .networkingError, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appearParsingError), name: .parsingError, object: nil)
    }
    
    @objc func appearNetworkingError() {
        let alertController = makeAlertController(title: "네트워크 오류", message: "네트워크 연결이 되어있지 않습니다.")
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func appearParsingError() {
        let alertController = makeAlertController(title: "데이터 오류", message: "데이터를 변환하지 못했습니다.")
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    private func makeAlertController(title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertAgain = UIAlertAction(title: "Retry", style: .default, handler: nil)
        alertController.addAction(alertCancel)
        alertController.addAction(alertAgain)
        return alertController
    }
}
