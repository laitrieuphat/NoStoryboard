//
//  HomeViewController.swift
//  NoStoryboard
//
//  Created by Minh on 11/9/25.
//

import UIKit

class HomeViewController: UIViewController {
    private var collectionView:UICollectionView?
    private var arrayCell = ["BannerCollectionViewCell","CategoryCollectionViewCell","ProductCollectionViewCell"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .yellow
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setupUI() {
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
        // register custom banner cell nib (ensure nib name matches)
        mainClsView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        // register default cell for other items
        mainClsView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(mainClsView)
    }
    
    
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // first cell -> banner
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            // configure banner with an array of images from assets
            let banners = ["banner1",
                           "banner2",
                           "banner_placeholder"].compactMap { UIImage(named: $0) }
            cell.configure(with: banners)
            return cell
        }
        // other cells
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        if indexPath.item == 0 {
            return CGSize(width: width, height: 250)
        }
        return CGSize(width: width, height: 1)
    }
}
