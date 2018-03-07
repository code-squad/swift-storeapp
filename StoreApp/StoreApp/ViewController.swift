//
//  ViewController.swift
//  StoreApp
//
//  Created by 심 승민 on 2018. 2. 20..
//  Copyright © 2018년 심 승민. All rights reserved.
//

import UIKit
import Toaster

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OrderResultDelegate {
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
    }

    private func loadItemsFromAPI(forSection section: TableSection, from server: Server) {
        Downloader.downloadWithDataTask(from: section.api(from: server)) { response in
            switch response {
            case .success(let result):
                guard let items = try? JSONDecoder().decode([StoreItem].self, from: result) else { break }
                DispatchQueue.main.async(execute: {
                    let newSection = Section(type: section, cells: items)
                    self.sections.append(newSection)
                    if let index = self.sections.index(of: newSection) {
                        let indexSet = IndexSet(integer: index)
                        self.tableView.insertSections(indexSet, with: .automatic)
                    }
                })
            case .failure(let error): self.presentErrorAlert(errorType: error)
            }
        }
    }

    func presentErrorAlert(errorType: NetworkError) {
        let alert = UIAlertController(title: errorType.alert.title,
                                      message: errorType.alert.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true, completion: nil)
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
        if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.reuseId)
            as? DetailViewController {
            detailVC.detailHash = row.detailHash
            detailVC.delegate = self
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    func toastOrderResult(_ orderInfo: OrderInfo) {
        ToastView.appearance().font = UIFont.boldSystemFont(ofSize: 15)
        let toaster = Toast(text: "\(orderInfo.menu)\n(이)가 주문되었습니다.")
        toaster.show()
    }

}
