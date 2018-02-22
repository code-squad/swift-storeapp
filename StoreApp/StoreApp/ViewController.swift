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

    @IBOutlet weak var tableView: UITableView!
    private var items = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        loadData(urlString: "http://crong.codesquad.kr:8080/woowa/main", sectionType: .main)
        loadData(urlString: "http://crong.codesquad.kr:8080/woowa/soup", sectionType: .soup)
        loadData(urlString: "http://crong.codesquad.kr:8080/woowa/side", sectionType: .side)
        tableView.register(UINib(nibName: "HeaderCell", bundle: nil), forCellReuseIdentifier: "HeaderCell")
    }

    private func loadData(urlString: String, sectionType: TableSection) {
        Downloader.download(urlString: urlString, toType: [StoreItem].self) { response -> Void in
            switch response {
            case .success(let items):
                let section = Section(section: sectionType, items: items)
                self.items.append(section)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error): NSLog(error.localizedDescription)
            }
        }
    }

    private func setData(jsonFileName: String, section: TableSection) {
        guard let data = Downloader.getDataFromJSONFile(jsonFileName) else { return }
        let decoder = JSONDecoder()
        var items: [StoreItem] = []
        do {
            items = try decoder.decode([StoreItem].self, from: data)
        } catch {
            NSLog(error.localizedDescription)
        }
        let section = Section(section: section, items: items)
        self.items.append(section)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.items[indexPath.section].cell[indexPath.row]
        ToastView.appearance().font = UIFont.boldSystemFont(ofSize: 15)
        let toaster = Toast(text: row.title+"\n"+row.salePrice)
        toaster.show()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].cell.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell else {
            return nil
        }
        header.title.text = items[section].title
        header.subtitle.text = items[section].subtitle
        return header
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.items[indexPath.section].cell[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? ItemCell else {
            return UITableViewCell()
        }
        cell.title.text = row.title
        cell.titleDescription.text = row.description
        cell.pricesContainer.normalPrice?.attributedText = row.normalPrice?.strike
        cell.pricesContainer.salePrice.attributedText = row.salePrice.salesHighlight
        cell.badges?.appendItems(with: row.badges)
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell else {
            return 0.0
        }
        return header.frame.height
    }

}
