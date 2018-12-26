//
//  ViewController.swift
//  StoreApp
//
//  Created by oingbong on 06/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var store = Store()
    private let errorMessage = "데이터를 가져오는데 에러가 발생하였습니다."
    private let alertButtonTitle = "어쩔 수 없죠.."
    private let storeItemCell = "StoreItemCell"
    private let storeHeaderCell = "StoreHeaderCell"
    
    private let titleSuccess = "주문성공"
    private let titleFail = "주문실패"
    private let messageSuccess = "😍 배송이 시작되면 또 안내드릴게요! 😍"
    private let messageFail = "😱 주문에 실패하였습니다. 다시 주문해주세요! 😱"
    private let buttonTitle = "확인"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureObservers()
        store.appendItem()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: storeItemCell, for: indexPath) as! StoreItemCell
        let items = store[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(from: items)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        let hash = store.detailHash(with: indexPath)
        let title = store.title(with: indexPath)
        detailVC.configure(with: hash, title: title)
        detailVC.delegate = self
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: Section
extension ViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return store.storeItemGroupCount
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return store[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: storeHeaderCell) as! StoreHeaderCell
        guard let topic = Topic(rawValue: section) else {
            return UIView(frame: CGRect(origin: .zero, size: .zero))
        }
        cell.configure(from: topic)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: Observers
extension ViewController {
    private func configureObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateItems), name: NotificationKey.updateItem, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(alert), name: NotificationKey.error, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateItemCell(_:)), name: NotificationKey.updateItemCell, object: nil)
    }
    
    @objc private func updateItems() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func alert() {
        let alert = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: alertButtonTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func updateItemCell(_ notification: Notification) {
        guard let indexPath = notification.userInfo?["indexPath"] as? IndexPath else { return }
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension ViewController: OrderToast {
    func show(with orderSheet: OrderSheet, status: Bool) {
        guard let customer = orderSheet.customer else { return }
        guard let price = orderSheet.price else { return }
        guard let menu = orderSheet.menu else { return }
        ToastCenter.default.cancelAll()
        let title = status ? titleSuccess : titleFail
        let message = status ? messageSuccess : messageFail
        let menuInfo = status ? "\(message)\n\(menu)\n\(price)" : ""
        let toastText = """
        \(customer)님 \(title)
        \(menuInfo)
        """
        Toast(text: toastText).show()
    }
}
