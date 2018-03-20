//
//  ViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private var sections = [Section]()
    private var dataLoader: DataLoader? {
        didSet {
            NotificationCenter.default.addObserver(self, selector: #selector(presentData(notification:)),
                                                   name: .dataLoaded, object: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.reuseId)
        dataLoader = DataLoader()
        dataLoader?.loadInitialData()
    }

    @objc func presentData(notification: Notification) {
        guard let passedData = notification.userInfo,
            let items = passedData["loadedItems"] as? LoadedItems else { return }
        DispatchQueue.main.async {
            self.present(items: items.data, on: items.section)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
    }

    private func present(items: [StoreItem], on section: TableSection) {
        let newSection = Section(type: section, cells: items)
        (TableSection.cases.count > self.sections.count) ? insertSection(newSection) : reloadSection(newSection)
    }

    private var reloadIndex = 0
    private func reloadSection(_ section: Section) {
        guard reloadIndex < TableSection.cases.count else {
            reloadIndex = 0
            return
        }
        self.sections[reloadIndex] = section
        if let index = self.sections.index(of: section) {
            let indexSet = IndexSet(integer: index)
            self.tableView.reloadSections(indexSet, with: .automatic)
        }
        defer {
            reloadIndex += 1
        }
    }

    private func insertSection(_ newSection: Section) {
        self.sections.append(newSection)
        if let index = self.sections.index(of: newSection) {
            let indexSet = IndexSet(integer: index)
            self.tableView.insertSections(indexSet, with: .automatic)
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.reuseId)
            as? DetailViewController {
            detailVC.detailHash = row.detailHash
            detailVC.delegate = self
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}

extension ViewController: OrderResultDelegate {
    func toastOrderResult(_ orderInfo: OrderInfo) {
        ToastView.appearance().font = UIFont.boldSystemFont(ofSize: 15)
        let toaster = Toast(text: "\(orderInfo.menu)\n(이)가 주문되었습니다.")
        toaster.show()
    }
}
