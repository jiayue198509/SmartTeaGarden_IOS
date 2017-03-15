//
//  ViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit


private let kCollectionViewCellID = "kCollectionViewCellID"
private let kHeaderViewID = "kHeaderViewID"
private let kEdgeInsetMargin : CGFloat = 10
private let kItemMargin : CGFloat = 10
private let kHeaderViewH : CGFloat = 50
private let kWaterLineViewH: CGFloat = 225
private let viewMargin: CGFloat = 10

let kNormalItemW = (kScreenW - 5 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4


class MainViewController: UIViewController {
    
    var mainContens = ["data1", "data2", "data3", "data4", "data5", "data6", "data7", "data8", "data9", "data10", "data11", "data12", "data13", "data14", "data15"]
    
    lazy var collectionView : UICollectionView = {[unowned self] in
        // 1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kNormalItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        let frame = CGRect(x: self.view.bounds.origin.x + viewMargin, y: 0, width: self.view.bounds.width - 2 * viewMargin, height: self.view.bounds.height)
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.register(UINib(nibName: "VideoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kCollectionViewCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "kHeaderViewID")
        
        return collectionView
    }()
    
    fileprivate lazy var waterView : WaterLineView = {
        let waterView = WaterLineView.waterLineView()
        waterView.frame = CGRect(x: 0, y: -kWaterLineViewH, width: kScreenW - 2 * viewMargin, height: kWaterLineViewH)
        return waterView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView.addSubview(waterView)
//        setConstraints()
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kWaterLineViewH, left: 0, bottom: 0, right: 0)
    }

    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }

}


extension MainViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainContens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath) as! VideoCollectionViewCell
        
        // 2.给cell设置数据
//        cell.anchor = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        cell.backgroundColor = UIColor.blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        // 2.给HeaderView设置数据
//        headerView.group = baseVM.anchorGroups[indexPath.section]
        
        return headerView
    }
}

extension MainViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 1.取出对应的信息
        

    }
}


//引导界面
extension MainViewController {
    fileprivate func showGuideView() {
        let guideView = GuideView(frame: view.bounds, pages: getGuidePages())
        guideView.showWithAnimationDuration(0.5)
    }
    
    fileprivate func getGuidePages() -> [UIView] {
        var guidePages: [UIView] = []
        
        for i in 1...3 {
            let imageName = String("guide\(i)")
            let imageView = UIImageView(frame: view.bounds)
            imageView.image = UIImage(named: imageName!)
            guidePages.append(imageView)
        }
        
        return guidePages
    }
    
    fileprivate func needShowGuideView() -> Bool {
        let userDefault = UserDefaults.standard
        
        return (!userDefault.bool(forKey: "isFirstLaunch"))
    }
}


//设置UI
extension MainViewController {
    func setupUI() {
        // 2.添加collectionView
        view.addSubview(collectionView)
        self.title = NSLocalizedString("app_name",comment: "")
        if needShowGuideView() {
            self.showGuideView()
        }
    }
    
    func setConstraints() {
        // 关闭autoresizing 不关闭否则程序崩溃
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //右边约束
        let right:NSLayoutConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.right, relatedBy:NSLayoutRelation.equal, toItem:self.view, attribute:NSLayoutAttribute.right, multiplier:1.0, constant: -10)
        collectionView.superview!.addConstraint(right)//父控件添加约束
        
        //右边约束
        let left:NSLayoutConstraint = NSLayoutConstraint(item: collectionView, attribute: NSLayoutAttribute.right, relatedBy:NSLayoutRelation.equal, toItem:self.view, attribute:NSLayoutAttribute.left, multiplier:1.0, constant: -10)
        collectionView.superview!.addConstraint(left)//父控件添加约束
    }
}

extension MainViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
