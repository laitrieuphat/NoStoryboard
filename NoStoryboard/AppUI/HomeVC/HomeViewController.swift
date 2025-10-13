//
//  HomeViewController.swift
//  NoStoryboard
//
//  Created by Minh on 11/9/25.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    private var typeOfTours:TypeOfTour = .outstanding
    private var outstandingTours:[Item] = []
    private var internationalTours:[Item] = []
    private var domesticTours:[Item] = []
    private var groupTours:[Item] = []
    private var largeBanners:[String] = []


    
    private var banners:[String] = []
    private let homeVM = HomeViewModel()
    private var mainClsView:UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
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
        mainClsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainClsView.backgroundColor = .white
        mainClsView.delegate = self
        mainClsView.dataSource = self
        mainClsView.translatesAutoresizingMaskIntoConstraints = false
        mainClsView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        mainClsView.register(UINib(nibName: "InforCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InforCollectionViewCell.identifier)
        mainClsView.register(UINib(nibName: "OutstandingTourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: OutstandingTourCollectionViewCell.identifier)
        mainClsView.register(UINib(nibName: "LargeBannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LargeBannerCollectionViewCell.indentifier)
        
//        mainClsView.register(UINib(nibName: "InternationTourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: InternationTourCollectionViewCell.indentifier)
        mainClsView.register(InternationTourCollectionViewCell.self, forCellWithReuseIdentifier: InternationTourCollectionViewCell.indentifier)
        mainClsView.register(DomesticTourCollectionViewCell.self, forCellWithReuseIdentifier: DomesticTourCollectionViewCell.indentifier)
        mainClsView.register(GroupTourCollectionViewCell.self, forCellWithReuseIdentifier: GroupTourCollectionViewCell.indentifier)
        // register default cell for unexpected items
        mainClsView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func bindingData(){
        homeVM.likeTourData.bind { tours in
            DispatchQueue.main.async{
                // reset collected large banners before processing
                self.largeBanners.removeAll()
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
                    case 419, 420, 422:
                        if let link = value.items.first?.imgLink {
                            self.largeBanners.append(link)

                        }
                    default:
                        break
                    }
                }
                self.mainClsView.reloadData()
            }
        }
        
        homeVM.banners.bind { [weak self ] banners in
            DispatchQueue.main.async {
                self?.banners = banners
                self?.mainClsView.reloadData()
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

            
            // count occurrences up to and including current index
            var occurrenceIndex = -1
            var bannerLargeString: String
            for i in 0...indexPath.item {
                if homeVM.arrItemsCell[i] == "LargeBannerCollectionViewCell" {
                    occurrenceIndex = occurrenceIndex + 1
                }
            }
            if occurrenceIndex >= 0 && occurrenceIndex < self.largeBanners.count {
                bannerLargeString = self.largeBanners[occurrenceIndex]
            }else{
                bannerLargeString = ""
            }
            
            cell.imageLargeBanner.load(urlString: bannerLargeString)

            return cell
        case "InternationTourCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InternationTourCollectionViewCell", for: indexPath) as? InternationTourCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.inject(data: internationalTours, homeVM: homeVM)
            return cell
            
        case "DomesticTourCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DomesticTourCollectionViewCell", for: indexPath) as? DomesticTourCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.inject(data: domesticTours, homeVM: homeVM)
            return cell
        case "GroupTourCollectionViewCell":
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupTourCollectionViewCell", for: indexPath) as? GroupTourCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.inject(data: groupTours, homeVM: homeVM)
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
            return CGSize(width: width, height: 380)
        case "LargeBannerCollectionViewCell":
            return CGSize(width: width, height: 350)
        case "InternationTourCollectionViewCell":
            return CGSize(width: width, height: 410)
        case "DomesticTourCollectionViewCell":
            return CGSize(width: width, height: 410)
        case "GroupTourCollectionViewCell":
            return CGSize(width: width, height: 410)
        default:
            return CGSize(width: width, height: 80)
        }
    }
}
