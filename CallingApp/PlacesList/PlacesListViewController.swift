//
//  PlacesListViewController.swift
//  CallingApp
//
//  Created by Hari Bista on 10/9/21.
//

import UIKit



class PlacesListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = PlacesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        self.tableView.reloadData()
        style()
    }
    
    func style() {
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func loadPlaces(){
        guard let query = self.searchBar.text else {
            return
        }
        
        // TODO:- show loading UI
        self.viewModel.fetchPlacesFor(query: query) { success, errorMessage in
            DispatchQueue.main.async {
                
                // TODO:- hide loading UI
                
                if success {
                    self.tableView.reloadData()
                } else {
                    print("fail")
                    // TODO:- show error UI
                }
            }
        }
    }
}

extension PlacesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PlacesListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        let place = self.viewModel.places[indexPath.row]
        cell.displayData(place: place)
        return cell
    }
}

extension PlacesListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.loadPlaces()
        self.searchBar.resignFirstResponder()
    }
}

