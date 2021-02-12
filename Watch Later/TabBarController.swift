//
//  WatchLaterTabBarController.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }

    private func configureTabBar() {
        let searchViewController = SearchViewController()
        let playlistViewController = PlaylistViewController()

        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        playlistViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)

        tabBar.tintColor = .red
        viewControllers = [searchViewController, playlistViewController]
    }
}
