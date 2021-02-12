//
//  ViewController.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import UIKit

class PlaylistViewController: UIViewController {
    let tableView = UITableView()
    let playlistManager = PlaylistManager()
    let tableViewCellName = "playlistCell"

    var playlistData = [SearchResultItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        playlistData = playlistManager.allSaved()
        tableView.reloadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistData.count > 0 ? playlistData.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard playlistData.count > 0 else {
            let noDataCell = UITableViewCell()
            noDataCell.isUserInteractionEnabled = false
            noDataCell.textLabel?.text = "No items yet"
            return noDataCell
        }
        let item = playlistData[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: tableViewCellName)
        cell.selectionStyle = .none
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.year

        return cell
    }
}
