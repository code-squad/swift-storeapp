//
//  ViewController.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 08/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import UIKit
import Toaster

// # MARK - ViewController

class StoreViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // let model: StoreModel = StoreModel()
    var delegate: StoreDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 모델 생성
        let model: StoreModel = StoreModel()
        
        // 델리게이트 생성
        self.delegate = StoreDelegate(model: model, complete: {
            DispatchQueue.main.async {
                // 불러온 결과를 테이블뷰에 표시
                self.tableView.reloadData()
            }
        }, fail: { (e) in
            print("something is fail")
            print(e ?? "!!unknown error")
        })
        
        // 테이블뷰 델리게이트와 데이터소스 설정
        tableView.delegate = delegate
        tableView.dataSource = delegate
        
        // 불러온 데이터를 테이블뷰에 표시
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// # MARK - TableView DataSource

class StoreDelegate: NSObject, UITableViewDataSource {
    
    let model: StoreModel
    
    init(model: StoreModel, complete: @escaping ()->(), fail: @escaping (Error?)->()) {
        self.model = model
        
        // 데이터 불러오기
        model.loadData(complete: complete, fail: fail)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.itemCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreItemCell", for: indexPath)
        if let productCell = cell as? StoreItemCell,
            let item = model.item(with: indexPath.section, with: indexPath.row) {
            productCell.setProductInfo(info: item)
        }
        return cell
    }
}


// # MARK - TableView Delegate

extension StoreDelegate: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreSectionHeader", for: IndexPath())
        if let sectionHeader = cell as? StoreSectionHeader {
            let sectionInfo = model.section(with: section)
            sectionHeader.set(info: sectionInfo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let item = model.item(with: indexPath.section, with: indexPath.row) {
            Toast(text: "\(item.title)\n\(item.s_price)").show()
        }
    }
}
