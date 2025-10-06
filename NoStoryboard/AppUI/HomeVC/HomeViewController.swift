//
//  HomeViewController.swift
//  NoStoryboard
//
//  Created by Minh on 11/9/25.
//

import UIKit

class HomeViewController: UIViewController {
    private var typeOfTours:TypeOfTour = .outstanding
    private var outstandingTours:[Item] = []
    private var internationalTours:[Item] = []
    private var domesticTours:[Item] = []
    private var groupTours:[Item] = []
    private var largeBanners:String? = nil
    
    
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
        homeVM.loadingDataLikeTour()
        
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
        mainClsView.register(UINib(nibName: "OutstandingTourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OutstandingTourCollectionViewCell.indentifier)
        mainClsView.register(UINib(nibName: "LargeBannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LargeBannerCollectionViewCell.indentifier)
        
        // register default cell for unexpected items
        mainClsView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func bindingData(){
        homeVM.likeTourData.bind { tours in
            DispatchQueue.main.async{
                for (_,value) in tours.enumerated(){
                    switch value.id{
                    case 301:
                        self.typeOfTours = .outstanding
                        self.outstandingTours = value.items.filter({ item in
                            !item.titleName.hasPrefix("set-5-yellow-stars")
                        })
                    case 421:
                        self.typeOfTours = .international
                        self.internationalTours = value.items.filter({ item in
                            !item.titleName.hasPrefix("set-5-yellow-stars")
                        })
                    case 423:
                        self.typeOfTours = .domestic
                        self.domesticTours  = value.items.filter({ item in
                            !item.titleName.hasPrefix("set-5-yellow-stars")
                        })
                    case 447:
                        self.typeOfTours = .group
                        self.groupTours  = value.items.filter({ item in
                            !item.titleName.hasPrefix("set-5-yellow-stars")
                        })
                    case 419:
                        self.largeBanners = value.items.first?.imgLink
                    default:
                        break
                    }
                }
                self.collectionView?.reloadData()
            }
        }
        
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
        return homeVM.arrItemsCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellName = homeVM.arrItemsCell[indexPath.item]
        
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
        case "OutstandingTourCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutstandingTourCollectionViewCell", for: indexPath) as? OutstandingTourCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.inject(data: outstandingTours, homeVM: homeVM)
            return cell
            
        case "LargeBannerCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LargeBannerCollectionViewCell", for: indexPath) as? LargeBannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.imageLargeBanner.load(urlString: largeBanners ?? "" )
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .red
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let cellName = homeVM.arrItemsCell[indexPath.item]
        
        switch cellName {
        case "BannerCollectionViewCell":
            return CGSize(width: width, height: 350)
        case "InforCollectionViewCell":
            return CGSize(width: width, height: 220)
        case "OutstandingTourCollectionViewCell":
            return CGSize(width: width, height: 350)
        case "LargeBannerCollectionViewCell":
            return CGSize(width: width, height: 350)
        default:
            return CGSize(width: width, height: 80)
        }
    }
}
