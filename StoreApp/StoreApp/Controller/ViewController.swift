//
//  ViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster
import Alamofire

class ViewController: UIViewController, ReachabilityDetectable, RespondableForNetwork {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    private var sections = [Section]()
    var reachabilityMonitor: ReachabilityMonitor? {
        didSet {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(onConnectionChanged(_:)),
                                                   name: .connectionChanged, object: nil)
        }
    }

    @objc private func onConnectionChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let isAvailable = userInfo["NetworkStatus"] as? Bool else { return }
        drawBorder(on: self.view, when: isAvailable)
        loadDataFromServer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: HeaderCell.reuseId)
        if let monitor = reachabilityMonitor, !monitor.isAvailable {
            loadDataFromLocal()
        }
    }

    private func loadDataFromLocal() {
        loadItemsFromFile(forSection: .main)
        loadItemsFromFile(forSection: .soup)
        loadItemsFromFile(forSection: .side)
    }

    private func loadDataFromServer() {
        loadItemsFromAPI(forSection: .main, from: .remote)
        loadItemsFromAPI(forSection: .soup, from: .remote)
        loadItemsFromAPI(forSection: .side, from: .remote)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        tableView.estimatedRowHeight = 40
        tableView.estimatedSectionHeaderHeight = 40
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        if let monitor = reachabilityMonitor {
            drawBorder(on: self.view, when: monitor.isAvailable)
        }
    }

    private func loadItemsFromFile(forSection section: TableSection) {
        guard let data = Downloader.getDataFromJSONFile(section.localFilename) else { return }
        presentDecodedData(on: section, from: data)
    }

    private func loadItemsFromAPI(forSection section: TableSection, from server: Server) {
        Downloader.downloadWithDataTask(from: section.api(from: server)) { response in
            switch response {
            case .success(let data):
                self.presentDecodedData(on: section, from: data)
            case .failure(let error):
                self.presentError(error)
            }
        }
    }

    private func presentDecodedData(on section: TableSection, from rawData: Data) {
        guard let items = try? JSONDecoder().decode([StoreItem].self, from: rawData) else { return }
        DispatchQueue.main.async(execute: {
            self.present(items: items, on: section)
        })
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
            detailVC.reachabilityMonitor = self.reachabilityMonitor
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
