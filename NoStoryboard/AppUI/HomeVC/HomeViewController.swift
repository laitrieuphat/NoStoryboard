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
    private var viewOnTop: ViewOnTopHomeView = {
        var view = ViewOnTopHomeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindingData() // bind first
        homeVM.loadBanners() // then request data
        
    }
    
    fileprivate func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        guard let mainClsView = collectionView else { return }
        view.addSubview(mainClsView)
        view.addSubview(viewOnTop)
        
        // Use safeAreaLayoutGuide for top constraint
        viewOnTop.alpha = 1
        viewOnTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewOnTop.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewOnTop.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewOnTop.heightAnchor.constraint(equalToConstant: 80).isActive = true
        viewOnTop.bottomAnchor.constraint(equalTo: mainClsView.topAnchor).isActive = true
        
        mainClsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainClsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainClsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        // configure collection view layout
        mainClsView.backgroundColor = .blue
        if let layout = mainClsView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = .zero
        }
        
        // configure collection view
//        mainClsView.frame = view.bounds
        // allow autoresizing so it resizes with view and doesn't cover tab bar
        mainClsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainClsView.backgroundColor = .white
        mainClsView.delegate = self
        mainClsView.dataSource = self
        mainClsView.translatesAutoresizingMaskIntoConstraints = false
        mainClsView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)

        mainClsView.register(UINib(nibName: "InforCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InforCollectionViewCell.identifier)
        // register default cell for unexpected items
        mainClsView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
            
            
        case "InforCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InforCollectionViewCell", for: indexPath) as? InforCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = .systemGray4
            return cell
            
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

        case "BannerCollectionViewCell":
            return CGSize(width: width, height: 350)
        case "InforCollectionViewCell":
            return CGSize(width: width, height: 200)

        default:
            return CGSize(width: width, height: 80)
        }
    }
}
