//
//  OutstandingTourCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 25/9/25.
//

import UIKit

class OutstandingTourCollectionViewCell: UICollectionViewCell {
  
    static let indentifier = "OutstandingTourCollectionViewCell"
    private var outstandingTours: [Item] = []
    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var outstandingTourClsView: UICollectionView!
    var homeVM: HomeViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    func inject(data outstandingTours:[Item], homeVM: HomeViewModel){
        self.homeVM = homeVM
        self.outstandingTours = outstandingTours
        self.outstandingTourClsView.reloadData()
    }
    
    private func setupCollectionView(){
        guard let outstandingTourClsView = outstandingTourClsView else { return }
        outstandingTourClsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        outstandingTourClsView.showsHorizontalScrollIndicator = false
        outstandingTourClsView.delegate = self
        outstandingTourClsView.dataSource = self
        outstandingTourClsView.register(UINib(nibName: "OutstandingItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OutstandingItemCollectionViewCell.identifier)
        if let layout = outstandingTourClsView.collectionViewLayout as? UICollectionViewFlowLayout {
        
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 1
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .zero
        }
    }
}

extension OutstandingTourCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return outstandingTours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutstandingItemCollectionViewCell", for: indexPath) as? OutstandingItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.titleNameItem.text = outstandingTours[indexPath.item].titleName
        cell.imgViewItem.load(urlString: outstandingTours[indexPath.item].imgLink)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: width/3, height: 400)
    }
    
}

extension OutstandingTourCollectionViewCell:OutstandingItemCollectionViewCellDelegate{
    func didSelectItem(at indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
    }
    
}
