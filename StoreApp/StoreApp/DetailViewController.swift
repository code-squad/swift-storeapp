//
//  StoreItemDetailViewController.swift
//  StoreApp
//
//  Created by moon on 2018. 8. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit

protocol DetailHashSettable {
    var detailHash: String { get }
}

protocol DetailViewControllerDelegate: class {
}

class DetailViewController: UIViewController {
    
    // MARK: IBOutlet
    @IBOutlet weak var detailView: DetailView!
    
    weak var delegate: DetailViewControllerDelegate?
    private var detailHash: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
    }
    
    func setDetailHash(_ setter: DetailHashSettable) {
        self.detailHash = setter.detailHash
    }
}

extension DetailViewController: DetailViewDelegate {
    func orderButtonDidTapped(_ orderButton: UIButton) {
    }
}
