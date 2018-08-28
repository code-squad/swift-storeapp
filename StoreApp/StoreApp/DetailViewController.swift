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
    var title: String { get }
}

protocol DetailViewControllerDelegate: class {
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailView: DetailView!
    
    weak var delegate: DetailViewControllerDelegate?
    private var hashData: HashData?
    private var detailViewSetwrapper: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.delegate = self
        detailViewSetwrapper()
    }
    
    func setDetailHash(_ setter: DetailHashSettable) {
        self.detailViewSetwrapper = {
            DataManager.fetchHashData(setter.detailHash) { [weak self] hashData in
                self?.detailView.setTitleLabelText(setter.title)
                self?.detailView.setDetailLabelText(with: hashData.data)
                self?.setThumbnailImages(hashData.data.thumbnailImageURLs)
                self?.setDetailImages(hashData.data.detailSectionURLs)
            }
        }
    }
    
    func setThumbnailImages(_ imageURLs: [String]) {
        imageURLs.forEach { setThumbnailImage($0) }
    }
    
    private func setThumbnailImage(_ imageURL: String) {
        ImageManager.downloadThumbnailImage(imageURL) { [weak self] data in
            guard let data = data else { return }
            self?.detailView.addThumbnailImage(data)
        }
    }
    
    func setDetailImages(_ imageURLs: [String]) {
        imageURLs.forEach { setDetailImage($0) }
    }
    
    private func setDetailImage(_ imageURL: String) {
        ImageManager.downloadThumbnailImage(imageURL) { [weak self] data in
            guard let data = data else { return }
            self?.detailView.addDetailImage(data)
        }
    }
}

extension DetailViewController: DetailViewDelegate {
    func orderButtonDidTapped(_ orderButton: UIButton) {
    }
    
    func didAddDetailImage(_ height: CGFloat) {
    }
}
