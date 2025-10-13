//
//  BannerImageCell.swift
//  NoStoryboard
//
//  Created by Minh on 24/9/25.
//

import Foundation
import UIKit
final class BannerImageCell: UICollectionViewCell {
    static let identifier = "BannerImageCell"
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.tag = 111
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        self.imageView.image = nil
        self.imageView.image = UIImage(systemName: "LogoLikeTour")
    }
    
    func configure(withImage url:URL?) {
        if let url = url {
            self.imageView.kf.setImage(with: url, options: nil) { result in
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
