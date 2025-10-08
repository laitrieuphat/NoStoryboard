//
//  InternationTourCollectionViewCell.swift
//  NoStoryboard
//
//  Created by Minh on 6/10/25.
//

import UIKit

class InternationTourCollectionViewCell: UICollectionViewCell {
    static let indentifier = "InternationTourCollectionViewCell"
    private var interTours: [Item] = []
    private var homeVM: HomeViewModel?
    private var titleLblInterTour: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textColor = .systemRed
        lbl.textAlignment = .center
        lbl.text = "TOUR QUỐC Tế"
        return lbl
    }()
    
    var interTourClsView:UICollectionView = {
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
    
    
    func inject(data interTours:[Item], homeVM: HomeViewModel){
        self.homeVM = homeVM
        self.interTours = interTours
        self.interTourClsView.reloadData()
    }
    
    private func setupConstraints(){
        // avoid adding constraints multiple times
        guard titleLblInterTour.superview == nil else { return }

        // add title, collection view, and the show more button
        contentView.addSubview(titleLblInterTour)
        contentView.addSubview(interTourClsView)
        contentView.addSubview(showMoreBtn)

        NSLayoutConstraint.activate([
            // Title label on top
            titleLblInterTour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLblInterTour.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLblInterTour.heightAnchor.constraint(equalToConstant: 30),

            // Collection view below title
            interTourClsView.topAnchor.constraint(equalTo: titleLblInterTour.bottomAnchor, constant: 8),
            interTourClsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            interTourClsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            // showMoreBtn will be below the collection view
            interTourClsView.bottomAnchor.constraint(equalTo: showMoreBtn.topAnchor, constant: -8),

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
        interTourClsView.collectionViewLayout = layout
        interTourClsView.delegate = self
        interTourClsView.dataSource = self
        interTourClsView.register(UINib(nibName: "ElementDetailItemTourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ElementDetailItemTourCollectionViewCell.identifier)
         setupConstraints()
     }
 }
 
 extension InternationTourCollectionViewCell:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let hight = interTourClsView.bounds.height
        return CGSize(width: width/3, height: hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interTours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ElementDetailItemTourCollectionViewCell.identifier, for: indexPath) as? ElementDetailItemTourCollectionViewCell else { return UICollectionViewCell()}
         
         cell.titleNameItem.text = interTours[indexPath.item].titleName
         cell.imgViewItem.load(urlString: interTours[indexPath.item].imgLink)
         cell.Subtile.text =  "Lịch khởi hành:\(interTours[indexPath.item].time.rawValue)"
         //        cell.delegate = self
         return cell
     }
    

    
}
