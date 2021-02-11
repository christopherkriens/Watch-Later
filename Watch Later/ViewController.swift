//
//  ViewController.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Service.search(query: "terminator", type: .movie) { result in
            switch result {
            case .success(let searchResult):
                print(searchResult)
            case .failure(let error):
                print(error)
            }
        }
    }
}

