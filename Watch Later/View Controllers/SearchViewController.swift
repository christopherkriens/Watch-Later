//
//  ViewController.swift
//  Watch Later
//
//  Created by Christopher Kriens on 2/11/21.
//

import UIKit

class SearchViewController: UIViewController {
    let navigationBar = UINavigationBar()
    let tableView = UITableView()
    let tableViewCellName = "searchResultCell"

    var resultSearchController = UISearchController()
    var searchResults = SearchResult()
    lazy var playlistManager = PlaylistService()

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        resultSearchController.isActive = false
    }

    private func setup() {
        view.addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        tableView.dataSource = self
        tableView.delegate = self

        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.searchBar.sizeToFit()
            controller.searchBar.placeholder = "Search for a movie"
            controller.obscuresBackgroundDuringPresentation = false
            controller.searchBar.tintColor = .red
            controller.searchBar.delegate = self

            return controller
        })()

        tableView.tableHeaderView = resultSearchController.searchBar
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = searchResults.search?.count else { return 1 }
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = searchResults.search?[indexPath.row] else {
            let errorCell = UITableViewCell()
            errorCell.isUserInteractionEnabled = false
            errorCell.textLabel?.text = searchResults.error
            return errorCell
        }
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: tableViewCellName)

        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.year
        cell.tintColor = .red

        cell.accessoryType = playlistManager.isSaved(item) ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = searchResults.search?[indexPath.row] else { return }

        playlistManager.isSaved(item) ? playlistManager.remove(item) : playlistManager.add(item)

        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        //guard let searchText = searchController.searchBar.text else { return }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults = SearchResult()
        self.tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }

        SearchService.search(query: searchText, type: .movie) { result in
            switch result {
            case .success(let searchResult):
                self.searchResults = searchResult

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)– \(error.rawValue)")
            }
        }
    }
}
