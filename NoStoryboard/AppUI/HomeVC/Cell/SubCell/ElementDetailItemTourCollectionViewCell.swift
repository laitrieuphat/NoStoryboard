//
//  OutstandingItemCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 25/9/25.
//

import UIKit
import Cosmos

protocol OutstandingItemCollectionViewCellDelegate {
    func didSelectItem(at indexPath: IndexPath)
}

class ElementDetailItemTourCollectionViewCell: UICollectionViewCell {
    static let identifier = "ElementDetailItemTourCollectionViewCell"
    var delegate: OutstandingItemCollectionViewCellDelegate?
    @IBOutlet weak var imgViewItem: UIImageView!
    @IBOutlet weak var titleNameItem: UILabel!
    @IBOutlet weak var Subtile: UILabel!
    @IBOutlet weak var ratingStart: UIView!
    
    lazy var cosmosView:CosmosView = {
        var view = CosmosView()
        view.settings.totalStars = 5
        view.settings.starSize = 20
        view.settings.starMargin = 3
        view.settings.fillMode = .precise
        
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewItem.layer.cornerRadius = 10
        setupCosmosView()
        
    }
        
    override func prepareForReuse() {
        imgViewItem.image = nil
        titleNameItem.text = nil
        Subtile.text = nil
        
    }
    
    public func configure(with item: Item) {
        
    }
    
    private func setupCosmosView(){
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        ratingStart.addSubview(cosmosView)
        cosmosView.didTouchCosmos = { rating in
            print("Rated: \(rating)")
        }
    }
        
}
