//
//  BannerCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import UIKit
import Kingfisher

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    @IBOutlet weak var BannerCollectionView: UICollectionView!
    var imgArr:[String] = [String]()
    var timer = Timer()
    var counter = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // configure collection view layout for horizontal scrolling
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        BannerCollectionView.collectionViewLayout = layout
        BannerCollectionView.showsHorizontalScrollIndicator = false
        BannerCollectionView.isPagingEnabled = true
        BannerCollectionView.isScrollEnabled = true
        
        // configure collection view
        BannerCollectionView.dataSource = self
        BannerCollectionView.delegate = self
        BannerCollectionView.register(BannerImageCell.self, forCellWithReuseIdentifier: BannerImageCell.identifier)
        startAutoScroll()
    }
    
    // Public configure method to provide banner images
    func configureUpdate(with urlStrings: [String]) {
        DispatchQueue.main.async {
            self.imgArr = urlStrings
            self.BannerCollectionView.reloadData()
            
        }
    }
    
    func stopAutoScroll()  {
        timer.invalidate()
    }
    
    func startAutoScroll(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    @objc func changeImage() {
        // Use contentOffset to move by one page width each tick. Wrap to start when reaching end.
        
        guard imgArr.count > 0 else { return }
        DispatchQueue.main.async {
            let width = self.BannerCollectionView.bounds.width
            guard width > 0 else { return }
            
            let maxOffsetX = max(self.BannerCollectionView.contentSize.width - self.BannerCollectionView.bounds.width, 0)
            var nextX = self.BannerCollectionView.contentOffset.x + width + 1
            var animated = true
            
            if nextX > maxOffsetX {
                // reached (or passed) end — wrap to beginning
                nextX = 0
                animated = false
            }
            
            self.BannerCollectionView.setContentOffset(CGPoint(x: nextX , y: 0), animated: animated)
        }
    }
}


extension BannerCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCell.identifier, for: indexPath) as? BannerImageCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(withImage: URL(string: imgArr[indexPath.item]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Make each banner cell the full width of the collection view so paging shows one banner at a time
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // stop auto scroll
        stopAutoScroll()
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // start
        startAutoScroll()
    }
}
