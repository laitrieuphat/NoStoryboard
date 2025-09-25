//
//  ViewOnTopHomeView.swift
//  NoStoryboard
//
//  Created by Minh on 25/9/25.
//

import UIKit

class ViewOnTopHomeView: UIView {
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var menuSlideBtn: UIButton!
    
    @IBOutlet var contentView: UIView!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        // load file xib từ bộ nhớ
        Bundle.main.loadNibNamed("ViewOnTopHomeView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }

}
