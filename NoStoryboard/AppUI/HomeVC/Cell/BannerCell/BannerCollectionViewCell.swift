//
//  BannerCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 12/9/25.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerCollectionViewCell"
    @IBOutlet weak var BannerCollectionView: UICollectionView!

    // data source for inner horizontal banners
    private var banners: [UIImage] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // configure collection view layout for horizontal scrolling
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        BannerCollectionView.collectionViewLayout = layout
        BannerCollectionView.showsHorizontalScrollIndicator = false
        BannerCollectionView.isPagingEnabled = true

        // configure collection view
        BannerCollectionView.dataSource = self
        BannerCollectionView.delegate = self
        BannerCollectionView.register(BannerImageCell.self, forCellWithReuseIdentifier: BannerImageCell.identifier)
    }

    // Public configure method to provide banner images
    func configure(with images: [UIImage]) {
        self.banners = images
        BannerCollectionView.reloadData()
    }

}

// Simple inner cell that shows one banner image
private class BannerImageCell: UICollectionViewCell {
    static let identifier = "BannerImageCell"
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        // Pin imageView to contentView
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with image: UIImage?) {
        imageView.image = image
    }
}

extension BannerCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCell.identifier, for: indexPath) as? BannerImageCell else {
            return UICollectionViewCell()
        }
        let image = banners[indexPath.item]
        cell.configure(with: image)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Make each banner cell the full width of the collection view so paging shows one banner at a time
        let width = collectionView.bounds.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}
