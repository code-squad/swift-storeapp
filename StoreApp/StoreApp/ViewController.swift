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
        loadItemsFromAPI(forSection: .main, from: .local)
        loadItemsFromAPI(forSection: .soup, from: .local)
        loadItemsFromAPI(forSection: .side, from: .local)
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }

    private func loadItemsFromAPI(forSection section: TableSection, from server: Server) {
        Downloader.download(from: section.api(from: server)) { response in
            switch response {
            case .success(let result):
                guard let items = try? JSONDecoder().decode([StoreItem].self, from: result) else { break }
                DispatchQueue.main.async(execute: {
                    let newSection = Section(type: section, cell: items)
                    self.sections.append(newSection)
                    if let index = self.sections.index(of: newSection) {
                        let indexSet = IndexSet(integer: index)
                        self.tableView.insertSections(indexSet, with: .automatic)
                    }
                })
            case .failure(let error): NSLog(error.localizedDescription)
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.sections[indexPath.section].cells[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.reuseId) as? ItemCell else {
            return UITableViewCell()
        }
        // 뷰에 데이터 삽입.
        cell.title.text = row.title
        cell.titleDescription.text = row.description
        cell.pricesContainer.normalPrice?.attributedText = row.normalPrice?.strike
        cell.pricesContainer.salePrice.attributedText = row.salePrice.salesHighlight
        cell.badges?.appendItems(with: row.badges)

        DispatchQueue.main.async {
            cell.thumbnail.image = row.thumbnail?.image
        }

        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderCell.reuseId) as? HeaderCell
        header?.title.text = sections[section].type.title
        header?.subtitle.text = sections[section].type.subtitle
        return header
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.sections[indexPath.section].cells[indexPath.row]
        ToastView.appearance().font = UIFont.boldSystemFont(ofSize: 15)
        let toaster = Toast(text: row.title+"\n"+row.salePrice)
        toaster.show()
    }

}
