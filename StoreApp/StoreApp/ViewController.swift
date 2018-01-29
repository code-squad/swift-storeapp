//
//  ViewController.swift
//  StoreApp
//
//  Created by yangpc on 2018. 1. 26..
//  Copyright © 2018년 yang hee jung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var storeItems = [StoreItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        storeItems = decodeJSONData(from: "main")
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
        return storeItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "TableViewCell",
            for: indexPath ) as! TableViewCell
        let storeBoard = storeItems[indexPath.row]
        cell.titleLabel.text = storeBoard.title
        cell.descriptionLabel.text = storeBoard.description
        cell.priceLabel?.text = storeBoard.s_price.priceString
        let badgesInCell = cell.badges
        if badgesInCell?.count != storeBoard.badge?.count {
            badgesInCell?.setBadges(tags: storeBoard.badge)
        }
        return cell
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
