//
//  ProductDetailViewController.swift
//  NoStoryboard
//
//  Created by Minh on 11/9/25.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var ScrollViewDetaiProduct: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollViewDetaiProduct.delegate = self
        // Nó được sử dụng trong trường hợp ta muốn cung cấp không gian bên trong cho childView.
        ScrollViewDetaiProduct.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
    }


}


extension ProductDetailViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("ContentOffSet of scroll view:  \(scrollView.contentOffset)")
    }
}
