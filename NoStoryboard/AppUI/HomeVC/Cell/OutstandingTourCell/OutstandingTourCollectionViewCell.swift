//
//  OutstandingTourCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 25/9/25.
//

import UIKit

class OutstandingTourCollectionViewCell: UICollectionViewCell {
    static let identifier = "OutstandingTourCollectionViewCell"
    private var outstandingTours: [Item] = []
    @IBOutlet weak var titleNameLbl: UILabel!
    @IBOutlet weak var outstandingTourClsView: UICollectionView!
    @IBOutlet weak var showMoreBtn: UIButton!
    var homeVM: HomeViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
        setupBtnShowMore()
    }
    
    func inject(data outstandingTours:[Item], homeVM: HomeViewModel){
        self.homeVM = homeVM
        self.outstandingTours = outstandingTours
        self.outstandingTourClsView.reloadData()
    }
    
    private func setupBtnShowMore(){
        self.showMoreBtn.translatesAutoresizingMaskIntoConstraints = false
        self.showMoreBtn.setTitle("Show More", for: .normal)
        self.showMoreBtn.setTitleColor(.white, for: .normal)
        self.showMoreBtn.backgroundColor = .systemGreen
        self.showMoreBtn.layer.cornerRadius = 2
        self.showMoreBtn.clipsToBounds = true
    }
    
    private func setupCollectionView(){
        guard let outstandingTourClsView = outstandingTourClsView else { return }
        outstandingTourClsView.backgroundColor = .clear
        outstandingTourClsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        outstandingTourClsView.showsHorizontalScrollIndicator = false
        outstandingTourClsView.delegate = self
        outstandingTourClsView.dataSource = self
        outstandingTourClsView.register(UINib(nibName: "ElementDetailItemTourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ElementDetailItemTourCollectionViewCell.identifier)
        if let layout = outstandingTourClsView.collectionViewLayout as? UICollectionViewFlowLayout {
        
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 5
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ElementDetailItemTourCollectionViewCell", for: indexPath) as? ElementDetailItemTourCollectionViewCell else {
            return UICollectionViewCell()
        }
        let dataOfItem:Item = outstandingTours[indexPath.item]
        cell.configure(with: dataOfItem)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width/3, height: height)
    }
    
}

extension OutstandingTourCollectionViewCell:OutstandingItemCollectionViewCellDelegate{
    func didSelectItem(at indexPath: IndexPath) {
        print("Selected item at \(indexPath)")
    }
    
}
