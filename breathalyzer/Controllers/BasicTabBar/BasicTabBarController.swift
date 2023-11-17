//
//  BasicTabBarController.swift
//  breathalyzer
//
//  Created by Sanchez on 26.07.2023.
//

import UIKit

class BasicTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    func setupControllers() {
        var controllers: [UIViewController] = []
        
        let loginVC = LoginController()
        controllers.append(UINavigationController(rootViewController: loginVC))
        loginVC.tabBarItem = .init(title: "Данные", image: .init(systemName: "stethoscope.circle.fill"), tag: 0)
        
        let historyVC = HistoryController()
        controllers.append(UINavigationController(rootViewController: historyVC))
        historyVC.tabBarItem = .init(title: "История", image: .init(systemName: "list.bullet.circle.fill"), tag: 1)
        
        self.viewControllers = controllers
    }

}
