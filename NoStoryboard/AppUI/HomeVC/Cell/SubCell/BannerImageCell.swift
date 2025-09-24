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
    
    func configure(withImage urlString: String?) {
        if let url = urlString{
            imageView.load(urlString: url )
        }
    }
}
