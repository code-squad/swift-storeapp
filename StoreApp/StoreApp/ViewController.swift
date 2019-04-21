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
        registReloadObserver()
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
    
    @objc func reloadMainSection() {
        let mainSection = IndexSet(integer: SectionTheme.main.rawValue)
        DispatchQueue.main.async {
            self.tableView.reloadSections(mainSection, with: .automatic)
        }
    }
    
    @objc func reloadSoupSection() {
        let soupSection = IndexSet(integer: SectionTheme.soup.rawValue)
        DispatchQueue.main.async {
            self.tableView.reloadSections(soupSection, with: .automatic)
        }
    }
    
    @objc func reloadSideSection() {
        let sideSection = IndexSet(integer: SectionTheme.side.rawValue)
        DispatchQueue.main.async {
            self.tableView.reloadSections(sideSection, with: .automatic)
        }
    }
}
