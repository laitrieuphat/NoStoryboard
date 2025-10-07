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
        lbl.text = "Tour Quốc Tế"
        return lbl
    }()
    
    var interTourClsView:UICollectionView = {
        let cls = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        cls.translatesAutoresizingMaskIntoConstraints = false
        cls.showsHorizontalScrollIndicator = false
        cls.backgroundColor = .clear
        return cls
    }()
    
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        setupCollectionView()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
//        setupConstraints()
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
        contentView.addSubview(titleLblInterTour)
        NSLayoutConstraint.activate([
            titleLblInterTour.widthAnchor.constraint(equalToConstant: 100),
            titleLblInterTour.heightAnchor.constraint(equalToConstant: 30),
            titleLblInterTour.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
           
            titleLblInterTour.bottomAnchor.constraint(equalTo: interTourClsView.topAnchor, constant: 0)
            ])
    }
        
    
    private func setupCollectionView(){
        contentView.addSubview(interTourClsView)
        interTourClsView.frame = contentView.bounds
        interTourClsView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        
        // Use Auto Layout constraints instead of setting frame/autoresizing
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        interTourClsView.collectionViewLayout = layout
        interTourClsView.delegate = self
        interTourClsView.dataSource = self
        interTourClsView.register(UINib(nibName: "OutstandingItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ElementDetailItemTourCollectionViewCell.identifier)

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutstandingItemCollectionViewCell", for: indexPath) as? ElementDetailItemTourCollectionViewCell else { return UICollectionViewCell()}
        
        cell.titleNameItem.text = interTours[indexPath.item].titleName
        cell.imgViewItem.load(urlString: interTours[indexPath.item].imgLink)
        cell.Subtile.text =  "Lịch khởi hành:\(interTours[indexPath.item].time.rawValue)"
        //        cell.delegate = self
        return cell
    }
    

    
}
