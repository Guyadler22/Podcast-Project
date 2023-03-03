//
//  ViewController.swift
//  iTunesPodcastProject
//
//  Created by Guy Adler on 26/02/2023.
//

import UIKit

class PodcastListViewController: UIViewController {
    
    var podCastResults:[PodcastResult] = [PodcastResult]()
    
    private let podcastTableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PodcastCellTableViewCell.self, forCellReuseIdentifier: PodcastCellTableViewCell.identifier)
        return tableView
    }()
    
    //Label if there is no result from searchBar
    private let label:UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "No results"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //SearchBar
    private let searchController : UISearchController = {
        let conroller = UISearchController(searchResultsController: nil)
        conroller.searchBar.placeholder = "Search for Podacast"
        conroller.obscuresBackgroundDuringPresentation = false // Let to select row even if the searchBar is open
        conroller.searchBar.searchBarStyle = .minimal
        return conroller
    }()
    
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(podcastTableView)
        view.addSubview(label)
        
        podcastTableView.delegate = self
        podcastTableView.dataSource = self
        
        navigationItem.searchController = self.searchController
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationController?.navigationBar.tintColor = .white
        
        setupLabel()
                
    }
    
    //MARK:- UI Setup
    private func setupLabel(){
        
        NSLayoutConstraint.activate([
            
            self.label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }

        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        podcastTableView.frame = view.bounds
    }
}
//MARK:- Extension UITableView

extension PodcastListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podCastResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PodcastCellTableViewCell.identifier, for: indexPath) as?
                PodcastCellTableViewCell else {
            return UITableViewCell()
        }
        
        let podcast = self.podCastResults[indexPath.row]
        cell.populate(podcast)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PodcastCellTableViewCell.CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsScreen = DetailsViewController()
        
        let podcat = podCastResults[indexPath.row] 
        
        detailsScreen.podcast = podcat
        
        self.navigationController?.pushViewController(detailsScreen, animated: true)
        
    }
    
}

//MARK:- Extension UISerachBar

extension PodcastListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        // This function canceled the last api request
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(callSearchPodcast), object: nil)
        //Execute the func after 0.8
        self.perform(#selector(callSearchPodcast), with: nil, afterDelay: 0.8)
    
    }
    
    @objc func callSearchPodcast() {
        let searchBar = self.searchController.searchBar
        
        guard let query = searchBar.text,
              //Check if there is text is not empty, triming spaces
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              //Check if there is more then 3 characters
              query.trimmingCharacters(in: .whitespaces).count >= 2 else {
            return
        }
        ApiCaller2.shared.itunesSearchRequest(query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let searchPodcasts):
                    self.label.isHidden = true
                    self.podCastResults = searchPodcasts.results
                   
                    if self.podCastResults.count == 0 {
                        // Show if "No result"
                        self.label.isHidden = false
                    }

                    self.podcastTableView.reloadData()
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.podCastResults.removeAll()
        self.label.isHidden = false
        self.podcastTableView.reloadData()
    }
}
