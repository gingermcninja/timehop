//
//  ViewController.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView:UICollectionView!
    @IBOutlet var searchBar:UISearchBar!
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    
    let gifRepo = GIFRepository()

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if(searchText.isEmpty){
                loadTrendingGIFs()
            } else {
                performSearch(with: searchText)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search GIFs"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        loadTrendingGIFs()
    }
    
    private func loadTrendingGIFs() {
        gifRepo.loadTrendingGIFs { (success, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            if success {
                DispatchQueue.main.async { () -> Void in
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    private func performSearch(with term:String) {
        gifRepo.loadGIFsWithSearchTerm(term: term) { (success, error) in
            if let err = error {
                print(err.localizedDescription)
            }
            if success {
                DispatchQueue.main.async { () -> Void in
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let gifArray = gifRepo.gifArray {
            return gifArray.count
        } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:GIFCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GIFCell
        if let gifArray = gifRepo.gifArray {
            cell.imageSource = gifArray[indexPath.row].images.fixed_width.url
        }
        return cell
    }

}

