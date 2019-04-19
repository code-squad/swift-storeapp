//
//  ViewController.swift
//  StoreApp
//
//  Created by 조재흥 on 19. 4. 9..
//  Copyright © 2019 hngfu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    //MARK: IBOutlet
    @IBOutlet weak var storeTableView: UITableView!
    
    //MARK: Presenter
    private let storePresenter = StorePresenter()
    
    //MARK: - Methods
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeTableView.dataSource = storePresenter
    }
}

extension ViewController: StoreTableView {
    
}
