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
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var storeItems = StoreItems()
    private lazy var storeAppDataSource = StoreTableViewDataSource(storeItems)
    private lazy var storeAppDelegate = StoreTableViewDelegate(storeItems)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registSetObserver()
        registReloadObserver()
        storeItems.getDataFromNetwork()
        tableView.dataSource = storeAppDataSource
        tableView.delegate = storeAppDelegate
    }
}

extension ViewController {
    private func registSetObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(setMainItem(notification:)), name: .getMain, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSoupItem(notification:)), name: .getSoup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setSideItem(notification:)), name: .getSide, object: nil)
    }
    
    @objc func setMainItem(notification: NSNotification) {
        guard let mainItem = notification.userInfo?["main"] as? [StoreItem] else { return }
        storeItems.setMain(mainItem)
    }
    
    @objc func setSoupItem(notification: NSNotification) {
        guard let soupItem = notification.userInfo?["soup"] as? [StoreItem] else { return }
        storeItems.setSoup(soupItem)
    }
    
    @objc func setSideItem(notification: NSNotification) {
        guard let sideItem = notification.userInfo?["side"] as? [StoreItem] else { return }
        storeItems.setSide(sideItem)
    }
}

extension ViewController {
    private func registReloadObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadMainSection), name: .setMain, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSoupSection), name: .setSoup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadSideSection), name: .setSide, object: nil)
    }
    
    @objc func reloadMainSection() {
        let mainSection = IndexSet(integer: SectionTheme.main.rawValue)
        tableView.reloadSections(mainSection, with: .automatic)
    }
    
    @objc func reloadSoupSection() {
        let soupSection = IndexSet(integer: SectionTheme.soup.rawValue)
        tableView.reloadSections(soupSection, with: .automatic)
    }
    
    @objc func reloadSideSection() {
        let sideSection = IndexSet(integer: SectionTheme.side.rawValue)
        tableView.reloadSections(sideSection, with: .automatic)
    }
}
