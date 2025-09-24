//
//  HomeViewController.swift
//  NoStoryboard
//
//  Created by Minh on 11/9/25.
//

import UIKit

class HomeViewController: UIViewController {
    private var banners:[String] = []
    private let homeVM = HomeViewModel()
    private var collectionView:UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingData() // bind first
        homeVM.loadBanners() // then request data
        
    }
    
    fileprivate func setupUI() {
        self.view.backgroundColor = .yellow
        self.navigationController?.navigationBar.isHidden = true
        
        // create collection view using view.bounds so it respects the tab bar / safe area
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        guard let mainClsView = collectionView else { return }
        // configure collection view layout
        mainClsView.backgroundColor = .blue
        if let layout = mainClsView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .zero
        }
        
        // configure collection view
        mainClsView.frame = view.bounds
        // allow autoresizing so it resizes with view and doesn't cover tab bar
        mainClsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainClsView.backgroundColor = .white
        mainClsView.delegate = self
        mainClsView.dataSource = self
        
        mainClsView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerCollectionViewCell")
        mainClsView.register(UINib(nibName: "LogoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LogoCollectionViewCell")
        
        
        // register default cell for unexpected items
        mainClsView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(mainClsView)
    }
    
    private func bindingData(){
        homeVM.banners.bind { [weak self ] banners in
            DispatchQueue.main.async {
                self?.banners = banners
                self?.collectionView?.reloadData()
            }
        }
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.arrayCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellName = homeVM.arrayCell[indexPath.item]
        
        switch cellName {
        case "BannerCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureUpdate(with: self.banners)
            return cell
            
        case "LogoCollectionViewCell":
            if let logoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoCollectionViewCell", for: indexPath) as? LogoCollectionViewCell {
                // configure logoCell if needed
                return logoCell
            }
            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoCollectionViewCell", for: indexPath)
            defaultCell.backgroundColor = .systemGray5
            return defaultCell
            
            //        case "CategoryCollectionViewCell":
            //            if let catCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell {
            //                return catCell
            //            }
            //            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath)
            //            defaultCell.backgroundColor = .systemGray4
            //            return defaultCell
            //
            //        case "ProductCollectionViewCell":
            //            if let prodCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell {
            //                return prodCell
            //            }
            //            let defaultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath)
            //            defaultCell.backgroundColor = .systemGray3
            //            return defaultCell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellName = homeVM.arrayCell[indexPath.item]
        
        switch cellName {
        case "LogoCollectionViewCell":
            return CGSize(width: width, height: 60)
        case "BannerCollectionViewCell":
            return CGSize(width: width, height: 350)
        default:
            return CGSize(width: width, height: 80)
        }
    }
}
