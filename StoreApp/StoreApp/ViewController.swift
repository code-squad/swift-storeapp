//
//  ViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private var sections = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.reuseId)
        loadItemsFromAPI(from: .local, forSection: .main)
        loadItemsFromAPI(from: .local, forSection: .soup)
        loadItemsFromAPI(from: .local, forSection: .side)
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }

    private func loadItemsFromAPI(from server: Server, forSection section: TableSection) {
        Downloader.download(urlString: section.api(from: server), toType: [StoreItem].self) { response -> Void in
            switch response {
            case .success(let items):
                let newSection = Section(type: section, cell: items)
                self.sections.append(newSection)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error): NSLog(error.localizedDescription)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cell.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.sections[indexPath.section].cell[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseId) as? ItemCell else {
            return UITableViewCell()
        }
        cell.set(item: row)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseId) as? HeaderCell
        header?.title.text = sections[section].type.title
        header?.subtitle.text = sections[section].type.subtitle
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.sections[indexPath.section].cell[indexPath.row]
        ToastView.appearance().font = UIFont.boldSystemFont(ofSize: 15)
        let toaster = Toast(text: row.title+"\n"+row.salePrice)
        toaster.show()
    }

}
