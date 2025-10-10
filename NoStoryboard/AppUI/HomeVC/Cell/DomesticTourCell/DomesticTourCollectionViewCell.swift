//
//  DomesticTourCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 10/10/25.
//

import Foundation

import UIKit

class DomesticTourCollectionViewCell: UICollectionViewCell {
    static let indentifier = "DomesticTourCollectionViewCell"
    private var domesTours: [Item] = []
    private var homeVM: HomeViewModel?
    private var titleLblInterTour: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textColor = .systemRed
        lbl.textAlignment = .center
        lbl.text = "TOUR QUỐC NỘi"
        return lbl
    }()
    
    var domesTourClsView:UICollectionView = {
        let cls = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cls.translatesAutoresizingMaskIntoConstraints = false
        cls.showsHorizontalScrollIndicator = false
        cls.backgroundColor = .clear
        return cls
    }()
    
    private lazy var showMoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Show More", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemGreen
        btn.layer.cornerRadius = 2
        btn.clipsToBounds = true
        // Optional: add target action later from the view controller via injection
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    func inject(data domesTours:[Item], homeVM: HomeViewModel){
        self.homeVM = homeVM
        self.domesTours = domesTours
        self.domesTourClsView.reloadData()
    }
    
    private func setupConstraints(){
        // avoid adding constraints multiple times
        guard titleLblInterTour.superview == nil else { return }

        // add title, collection view, and the show more button
        contentView.addSubview(titleLblInterTour)
        contentView.addSubview(domesTourClsView)
        contentView.addSubview(showMoreBtn)

        NSLayoutConstraint.activate([
            // Title label on top
            titleLblInterTour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLblInterTour.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLblInterTour.heightAnchor.constraint(equalToConstant: 30),

            // Collection view below title
            domesTourClsView.topAnchor.constraint(equalTo: titleLblInterTour.bottomAnchor, constant: 8),
            domesTourClsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            domesTourClsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            // showMoreBtn will be below the collection view
            domesTourClsView.bottomAnchor.constraint(equalTo: showMoreBtn.topAnchor, constant: -8),

            showMoreBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            showMoreBtn.widthAnchor.constraint(equalToConstant: 133),
            showMoreBtn.heightAnchor.constraint(equalToConstant: 27),
            showMoreBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
     }
         
     private func setupCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 0
         domesTourClsView.collectionViewLayout = layout
         domesTourClsView.delegate = self
         domesTourClsView.dataSource = self
         domesTourClsView.register(UINib(nibName: "ElementDetailItemTourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ElementDetailItemTourCollectionViewCell.identifier)
         setupConstraints()
     }
 }
 
 extension  DomesticTourCollectionViewCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let hight = domesTourClsView.bounds.height
        return CGSize(width: width/3, height: hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return domesTours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementDetailItemTourCollectionViewCell.identifier, for: indexPath) as? ElementDetailItemTourCollectionViewCell else { return UICollectionViewCell()}
         
         cell.titleNameItem.text = domesTours[indexPath.item].titleName
         cell.imgViewItem.load(urlString: domesTours[indexPath.item].imgLink)
         cell.Subtile.text =  "Lịch khởi hành:\(domesTours[indexPath.item].time.rawValue)"
         //        cell.delegate = self
         return cell
     }
    

    
}
