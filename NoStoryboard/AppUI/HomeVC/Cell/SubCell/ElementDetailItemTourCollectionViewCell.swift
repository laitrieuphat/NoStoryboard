//
//  OutstandingItemCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 25/9/25.
//

import UIKit
protocol OutstandingItemCollectionViewCellDelegate {
    func didSelectItem(at indexPath: IndexPath)
}

class ElementDetailItemTourCollectionViewCell: UICollectionViewCell {
    static let identifier = "ElementDetailItemTourCollectionViewCell"
    var delegate: OutstandingItemCollectionViewCellDelegate?
    @IBOutlet weak var imgViewItem: UIImageView!
    
    @IBOutlet weak var titleNameItem: UILabel!
    
    @IBOutlet weak var Subtile: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewItem.layer.cornerRadius = 10
    }

    
    override func prepareForReuse() {
        imgViewItem.image = nil
        titleNameItem.text = nil
        Subtile.text = nil
        
    }
}
