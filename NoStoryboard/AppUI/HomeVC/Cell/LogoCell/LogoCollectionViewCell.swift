//
//  LogoCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 23/9/25.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {
    static let identifier = "LogoCollectionViewCell"
    @IBOutlet weak var ContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.ContentView.backgroundColor = .black
    }

}
