//
//  OutstandingItemCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 25/9/25.
//

import UIKit

class OutstandingItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "OutstandingItemCollectionViewCell"
    
    @IBOutlet weak var imgViewItem: UIImageView!
    
    @IBOutlet weak var titleNameItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
