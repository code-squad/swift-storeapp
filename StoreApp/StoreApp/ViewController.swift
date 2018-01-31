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
    var storeDataSource = StoreDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            UINib(nibName: .headerView, bundle: nil),
            forCellReuseIdentifier: .headerView
        )
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidAppear(_ animated: Bool) {
        let resources: [String] = [.main, .soup, .side]
        do {
            try storeDataSource.setItems(resources: resources)
        } catch let error {
            showAlert(message: error.localizedDescription)
        }
        tableView.reloadData()
    }
}

extension ViewController {
    
    private func showAlert(title: String = "잠깐!", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeDataSource.numberOfRowsInSection(section: section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.numberOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: .tableViewCell,
            for: indexPath ) as! TableViewCell
        let selectedItem = storeDataSource.item(indexPath: indexPath)
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
        let headerCell = tableView.dequeueReusableCell(withIdentifier: .headerView) as? HeaderView
        let section = Section(rawValue: section)
        headerCell?.titleLabel.text = section?.title
        headerCell?.descriptionLabel.text = section?.detail
        return headerCell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
}
