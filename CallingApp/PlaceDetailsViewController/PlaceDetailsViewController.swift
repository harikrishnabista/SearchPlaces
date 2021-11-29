//
//  PlaceDetailsViewController.swift
//  CallingApp
//
//  Created by Hari Bista on 10/10/21.
//

import Foundation
import UIKit

class PlaceDetailsViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var openLabel: PaddingLabel!
    @IBOutlet weak var detailsStackView: UIStackView!
    
    private let flowLayout = UICollectionViewFlowLayout()
    var place: PlaceSummary!
    
    private var viewModel = PlaceDetailsViewModel()
    
    // Details UI Elements
    @IBOutlet weak var websiteLabel: PaddingLabel!
    
    @IBOutlet weak var addressLabel: PaddingLabel!
    @IBOutlet weak var openHoursLabel: PaddingLabel!
    @IBOutlet weak var phoneLabel: PaddingLabel!
    
    @IBOutlet weak var openHoursView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
        self.viewModel.place = place
        self.displayData(place: self.place)
        
        self.loadPlaceDetails()
        self.photoCollectionView.reloadData()
        
        self.title = place.businessType
    }
    
    func loadPlaceDetails(){
        self.viewModel.fetchPlaceDetails { success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    self.displayPlaceDetails()
                    self.photoCollectionView.reloadData()
                } else {
                    print(errorMessage)
                    //TODO: display error UI
                }
            }
        }
    }
    
    private func setupCollectionView(){
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
    }
    
    private func style(){
        self.containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.containerView.layer.borderWidth = 0.5
        self.containerView.layer.cornerRadius = 8.0

        openLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        openLabel.layer.cornerRadius = 10.0
        openLabel.clipsToBounds = true
    }
    
    private func displayData(place: PlaceSummary) {
        style()
        
        self.nameLabel.text = place.name
        self.distanceLabel.text = "\(String(format: "%.1f", place.distance)) Meters away"
        
        if let openNow = place.openingHours?.openNow {
            self.openLabel.isHidden = false
            self.openLabel.text = openNow ? "Open" : "Closed"
        } else {
            self.openLabel.isHidden = true
        }

        self.typesLabel.text = place.displayValueForTypes
        
        self.displayOpenNowLabel(place: place)
        self.displayRatingUI(for: place)
    }
    
    private func displayRatingUI(for place: PlaceSummary) {
        self.ratingLabel.text = "\(String(describing: place.rating))"
        self.ratingCountLabel.text = "(by: \(String(place.userRatingsTotal)))"
        
        self.ratingStackView.removeAllArrangedSubviews()
        let rating = Int(place.rating.rounded(.down))

        for _ in 0...(rating - 1) {
            let ratingImgegeView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            ratingImgegeView.image = UIImage(named: "starFullFilled")?.withTintColor(.systemGreen)
            self.ratingStackView.addArrangedSubview(ratingImgegeView)
        }
    }
    
    private func displayOpenNowLabel(place: PlaceSummary) {
        if let openNow = place.openingHours?.openNow {
            self.openLabel.isHidden = false
            self.openLabel.text = openNow ? "Open" : "Closed"
        } else {
            self.openLabel.isHidden = true
        }
    }
    
    private func displayPlaceDetails(){
        guard let placeDetails = self.viewModel.placeDetails else {return}
        
        self.websiteLabel.text = placeDetails.website
        self.phoneLabel.text = placeDetails.formattedPhoneNumber
        self.addressLabel.text = placeDetails.formattedAddress
        
        self.openHoursLabel.numberOfLines = 0
        if let openHours = placeDetails.openingHours {
            openHoursView.isHidden = false
            self.openHoursLabel.text = placeDetails.openingHours?.displayOpenHoursValue
        } else {
            openHoursView.isHidden = true
            self.openHoursLabel.text = ""
        }
    }
    
    @IBAction func websiteTapGestureTapped(_ sender: Any) {
        guard let placeDetails = self.viewModel.placeDetails else {return}
        if let url = URL(string: placeDetails.website) {
            UIApplication.shared.open(url)
         }
    }
    
    @IBAction func phoneTapGesturesTapped(_ sender: Any) {
        guard let placeDetails = self.viewModel.placeDetails else {return}
        if let url = URL(string: "tel://\(placeDetails.formattedPhoneNumber)") {
            UIApplication.shared.open(url)
         }
    }
    
}

extension PlaceDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
    
}

extension PlaceDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("")
    }
}

extension PlaceDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.placeDetails?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let photos = self.viewModel.placeDetails?.photos,
           let photoReferenceUrl = photos[indexPath.row].photoReferenceUrl {
            cell.display(photoReferenceUrl: photoReferenceUrl)
        }
        
        return cell
    }
}
