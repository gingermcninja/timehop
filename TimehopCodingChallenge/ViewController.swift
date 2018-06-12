//
//  ViewController.swift
//  TimehopCodingChallenge
//
//  Created by Paul McGrath on 6/11/18.
//  Copyright © 2018 Paul McGrath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource {
    
    /**
     Collection view to display the GIF images
    */
    @IBOutlet var collectionView:UICollectionView!
    
    /**
     Search controller to manage our searches
    */
    var searchController:UISearchController = UISearchController(searchResultsController: nil)
    
    /**
     GIFRepository object to manage our list of GIFs
    */
    let gifRepo:GIFRepository = GIFRepository()

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
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        loadTrendingGIFs()
    }
    
    /**
     Loads the trending GIFs and reloads the collection view
    */
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
    
    /**
     Performs a search of GIFs based on the input search term

     - parameter term: The string to search for
    */
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

