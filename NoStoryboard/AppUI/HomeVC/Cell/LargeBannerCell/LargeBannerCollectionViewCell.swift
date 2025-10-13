//
//  LargeBannerCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Lai Minh on 27/9/25.
//

import UIKit

class LargeBannerCollectionViewCell: UICollectionViewCell {
    static let indentifier = "LargeBannerCollectionViewCell"
    
    @IBOutlet weak var imageLargeBanner: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        imageLargeBanner.image = nil
    }
    
    func configure(withImage url:URL?) {
        if let url = url {
            self.imageLargeBanner.kf.setImage(with: url, options: nil) { result in
                switch result {
                case .success(let imageResult):
                    print("Image banner loaded from cache: \(imageResult.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
