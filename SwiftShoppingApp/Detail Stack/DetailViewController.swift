//
//  DetailViewController.swift
//  SwiftShoppingApp
//
//  Created by GwakDoyoung on 13/07/2018.
//  Copyright © 2018 tucan9389. All rights reserved.
//

import UIKit
import Toaster

class DetailViewController: UIViewController {
    
    var storeItem: StoreItem?
    var model: DetailModel = DetailModel()
    
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pagingScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var deliveryInfoLabel: UILabel!
    @IBOutlet weak var deliveryFeeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let storeItem = storeItem else { return; }
        
        titleLabel.text = storeItem.title
        descriptionLabel.text = storeItem.description
        priceLabel.text = storeItem.s_price
        pageControl.numberOfPages = 0
        pagingScrollView.delegate = self
        
        model.loadData(with: storeItem.detail_hash) { (productItem, e) in
            DispatchQueue.main.async {
                if let productItem = productItem {
                    // ui setting
                    self.descriptionLabel.text = productItem.product_description
                    self.mileageLabel.text = productItem.point
                    self.deliveryInfoLabel.text = productItem.delivery_info
                    self.deliveryFeeLabel.text = productItem.delivery_fee
                    self.priceLabel.text = productItem.prices.last
                    self.pageControl.numberOfPages = productItem.thumb_images.count
                    
                    // load images
                    self.loadThubImages(with: productItem.thumb_images)
                    self.loadContentImages(with: productItem.detail_section)
                }
            }
        }
    }
    
    func loadThubImages(with imageURLs: [String]) {
        let imageCount = imageURLs.count
        pagingScrollView.isPagingEnabled = true
        pagingScrollView.contentSize = CGSize(width: pagingScrollView.frame.width * CGFloat(imageCount),
                                              height: pagingScrollView.frame.height)
        
        var imageX: CGFloat = 0
        for imageURL in imageURLs {
            let imageView = UIImageView(url: imageURL)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            imageView.frame = CGRect(x: imageX, y: 0,
                                     width: pagingScrollView.frame.width,
                                     height: pagingScrollView.frame.height)
            pagingScrollView.addSubview(imageView)
            imageX += pagingScrollView.frame.width
        }
    }
    
    func loadContentImages(with imageURLs: [String]) {
        for imageURL in imageURLs {
            let imageView = UIImageView(url: imageURL)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            stackView.addArrangedSubview(imageView)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @IBAction func touchPageControl(_ sender: Any) {
        if let pageControl = sender as? UIPageControl {
            let x = CGFloat(pageControl.currentPage) * pagingScrollView.frame.size.width
            pagingScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
        }
    }
    
    @IBAction func touchPurchase(_ sender: Any) {
        let purchaseModel = PurchaseModel()
        purchaseModel.delegate = self
        let text = (storeItem?.s_price ?? "N/A") + "-" + (storeItem?.title ?? "N/A")
        purchaseModel.purchase(with: text)
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

extension DetailViewController: PurchaseModelDelegate {
    func didFinishPurchase(_ success: Bool, text: String) {
        if let navi = self.navigationController {
            let title = success ? "주문 완료" : "주문 실패"
            Toast(text: title + "\n" + "\(text)").show()
            DispatchQueue.main.async {
                navi.popViewController(animated: true)
            }
        }
    }
}

// 네트워크와 뷰를 분리하지 못했습니다 ㅠㅠ
extension UIImageView {
    convenience init(url imageURL: String) {
        self.init(frame: .zero)
        guard let url = URL(string: imageURL) else { return; }
        
        self.image = nil
        if let imageFromCache = CacheManager.shared.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            self.setContraint()
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let error = error { print(error); self.image = nil; return }
                DispatchQueue.main.async(execute: {
                    if let unwrappedData = data,
                        let imageToCache = UIImage(data: unwrappedData) {
                        CacheManager.shared.setObject(imageToCache, forKey: url as AnyObject)
                        self.image = imageToCache
                        self.setContraint()
                    }
                })
            }).resume()
        }
    }
    
    func setContraint() {
        guard let image = self.image else { return; }
        
        let aspect = image.size.width / image.size.height
        
        let constraint = NSLayoutConstraint(item: self, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: aspect, constant: 0.0)
        constraint.priority = .required//UILayoutPriority(rawValue: 999)
        
        self.addConstraint(constraint)
    }
}
