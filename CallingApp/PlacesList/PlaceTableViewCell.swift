//
//  #imageLiteral(resourceName: "icons8-star-filled-50.png")#imageLiteral(resourceName: "icons8-star-half-50.png")PlaceTableViewCell.swift
//  CallingApp
//
//  Created by Hilen Adhikari on 10/9/21.
//

import Foundation
import UIKit
import CoreLocation

@IBDesignable class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 8.0
    @IBInspectable var bottomInset: CGFloat = 8.0
    @IBInspectable var leftInset: CGFloat = 8.0
    @IBInspectable var rightInset: CGFloat = 8.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
}

class PlaceTableViewCell : UITableViewCell {
    
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var openLabel: PaddingLabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var iconContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    func style(){
        self.containerView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        self.containerView.layer.borderWidth = 0.5
        self.containerView.layer.cornerRadius = 8.0

        iconContainerView.layer.cornerRadius = iconContainerView.bounds.height/2
        iconContainerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        
        openLabel.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
        openLabel.layer.cornerRadius = 10.0
        openLabel.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayData(place: Place) {
        self.nameLabel.text = place.nameDisplayValue

        self.ratingLabel.text = "\(String(describing: place.rating))"
        self.ratingCountLabel.text = "(by: \(String(place.userRatingsTotal)))"
        
        if let openNow = place.openingHours?.openNow {
            self.openLabel.isHidden = false
            self.placeHolderView.isHidden = false
            self.openLabel.text = openNow ? "Open" : "Closed"
        } else {
            self.openLabel.isHidden = true
            self.placeHolderView.isHidden = true
        }

        self.typesLabel.text = place.displayValueForTypes

        self.iconImageView.image = UIImage(named: "noImage")
        
//        URL(string: "https://maps.googleapis.com/maps/api/place/photo?photo_reference=" +  place.reference
        
        if let iconUrl = URL(string: place.icon) {
            ImageDownloadHelper.shared.downloadImage(url: iconUrl) { image in
                DispatchQueue.main.async {
                    self.iconImageView.image = image
                }
            }
        }
        
        self.displayRatingUI(for: place)
    }
    
    func displayRatingUI(for place: Place) {
        self.ratingStackView.removeAllArrangedSubviews()
        let rating = Int(place.rating.rounded(.down))

        for _ in 0...(rating - 1) {
            let ratingImgegeView = UIImageView(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
            let heightConstraint = ratingImgegeView.heightAnchor.constraint(equalToConstant: 14)
            ratingImgegeView.image = UIImage(named: "starFullFilled")?.withTintColor(.systemGreen)
            heightConstraint.isActive = true
            let widthConstraint = ratingImgegeView.widthAnchor.constraint(equalToConstant: 14)
            widthConstraint.isActive = true
            self.ratingStackView.addArrangedSubview(ratingImgegeView)
        }
    }
    
}

extension Place {
    
    var nameDisplayValue : String {
        let distance = "\(String(format: "%.1f", self.distance)) meters"
        return self.name +  " (\(distance))"
    }
    
    var displayValueForTypes: String {
        var result = ""
        for (i,item) in self.types.enumerated() {
            if i == 0 {
                result = result + item
            } else {
                result = result + " . " + item
            }
        }
        return result
    }
    
    var distance: CLLocationDistance {
        let placeLocation = CLLocation(
            latitude: self.geometry.location.lat,
            longitude: self.geometry.location.lng
        )
        return DistanceCalculater.calculate(placeLocation: placeLocation)
    }
}
