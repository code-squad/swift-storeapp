//
//  ViewController.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 26..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var mainItems = [StoreItem]()
    var soupItems = [StoreItem]()
    var sideItems = [StoreItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HeaderView", bundle: nil) , forCellReuseIdentifier: "HeaderView")
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        mainItems = decodeJSONData(from: .main)
        soupItems = decodeJSONData(from: .soup)
        sideItems = decodeJSONData(from: .side)
        tableView.reloadData()
    }
}

extension ViewController {
    private func decodeJSONData(from filename: String) -> [StoreItem] {
        do {
            let data = try DataManager.getJSONDataFromURL(filename)
            let items = try JSONDecoder().decode([StoreItem].self, from: data)
            return items
        } catch let error {
            showAlert(message: error.localizedDescription)
        }
        return []
    }

    private func showAlert(title: String = "잠깐!", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch Section(rawValue: section) {
        case .main?: count = mainItems.count
        case .soup?: count = soupItems.count
        case .side?: count = sideItems.count
        case .none: break }
        return count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.numberOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TableViewCell",
            for: indexPath ) as! TableViewCell
        var selectedItem: StoreItem? = nil
        let section = indexPath.section
        let row = indexPath.row
        switch Section(rawValue: section) {
        case .main?: selectedItem = mainItems[row]
        case .soup?: selectedItem = soupItems[row]
        case .side?: selectedItem = sideItems[row]
        case .none: break }
        cell.titleLabel.text = selectedItem?.title
        cell.descriptionLabel.text = selectedItem?.description
        cell.priceLabel?.text = selectedItem?.s_price.priceString
        cell.badges.setBadges(tags: selectedItem?.badge)
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderView") as? HeaderView
        let section = Section(rawValue: section)
        headerCell?.titleLabel.text = section?.title
        headerCell?.descriptionLabel.text = section?.detail
        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}

extension ViewController {
    enum Section: Int {
        case main, soup, side
        var title: String {
            switch self {
            case .main: return "메인반찬"
            case .soup: return "국.찌게"
            case .side: return "밑반찬" }
        }
        var detail: String {
            switch self {
            case .main: return "메인반찬 / 한그릇 뚝딱 메인 요리"
            case .soup: return "국.찌게 / 김이 모락모락 국.찌게"
            case .side: return "밑반찬 / 언제 먹어도 든든한 밑반찬" }
        }
        static var numberOfSections: Int { return 3 }
    }
}
