//
//  mainTapBarVC.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/08/18.
//

import UIKit

class MainTapBarViewController : UITabBarController {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //어떤건지 정의해줌
            let mainHomeVC = HomeViewController()
            let searchVC = SearchViewController()
            
            //배열순으로 탭바에 들어감
            self.viewControllers = [mainHomeVC, searchVC]
            
            //tabbarItem을 정해줌
            let mainHomeTabBarItem = UITabBarItem(title: "피드",image: UIImage(systemName: "house"), tag: 0)
            let searchTabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 1)
            //정의된 것에 tabbarItem을 지정해줌
            mainHomeVC.tabBarItem = mainHomeTabBarItem
            searchVC.tabBarItem = searchTabBarItem
        }
}
