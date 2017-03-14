//
//  LeftViewController.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 12/3/14.
//

import UIKit

enum LeftMenu: Int {
    case history = 0
    case about
    case exit
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : UIViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = [NSLocalizedString("video_history", comment: ""), NSLocalizedString("about", comment: ""), NSLocalizedString("exit", comment: "")]
    
    var menuIcon = [UIImage(named: "video_history")!, UIImage(named: "about")!, UIImage(named: "exit")!]
    
    var mainViewController: UINavigationController!
    var historyViewController: UIViewController!
    var aboutViewController: UIViewController!
    var loginViewController: UIViewController!
    var imageHeaderView: ImageHeaderView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        
        let storyboard = UIStoryboard(name: "Slide", bundle: nil)
        self.aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutVC") as! AboutUsViewController
//        self.aboutViewController = UINavigationController(rootViewController: aboutUsViewController)
//
//        let javaViewController = storyboard.instantiateViewController(withIdentifier: "JavaViewController") as! JavaViewController
//        self.javaViewController = UINavigationController(rootViewController: javaViewController)
//        
//        let goViewController = storyboard.instantiateViewController(withIdentifier: "GoViewController") as! GoViewController
//        self.goViewController = UINavigationController(rootViewController: goViewController)
//        
//        let nonMenuController = storyboard.instantiateViewController(withIdentifier: "NonMenuController") as! NonMenuController
//        nonMenuController.delegate = self
//        self.nonMenuViewController = UINavigationController(rootViewController: nonMenuController)
        
//        self.tableView.registerCellClass(LeftMenuTableViewCell.self)
        self.tableView.registerCellNib(LeftMenuTableViewCell.self)
        
        self.imageHeaderView = ImageHeaderView.loadNib()
        self.view.addSubview(self.imageHeaderView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imageHeaderView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200)
        self.view.layoutIfNeeded()
    }
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .about:
            self.mainViewController.pushViewController(aboutViewController, animated: true)
            self.slideMenuController()?.closeLeft()
        case .history:
            self.mainViewController.pushViewController(aboutViewController, animated: true)
            self.slideMenuController()?.closeLeft()
        case .exit:
            self.slideMenuController()?.changeMainViewController(self.loginViewController, close: true)
        }
    }
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .history, .about, .exit:
                return LeftMenuTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(menu)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: indexPath.row) {
            switch menu {
            case .history, .about, .exit:
                let a = LeftMenuTableViewCell.identifier
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: LeftMenuTableViewCell.identifier) as! LeftMenuTableViewCell
                
                let data = LeftMenuTableViewCellData(image: menuIcon[indexPath.row], text: menus[indexPath.row])
                cell.setData(data)
                if menu == .exit {
                    cell.accessoryType = .none
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}
