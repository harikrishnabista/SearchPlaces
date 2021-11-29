//
//  PhotoCell.swift
//  CallingApp
//
//  Created by Hari Bista on 10/10/21.
//

import Foundation
import UIKit

class PhotoCell : UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoImageView.layer.cornerRadius = 8.0
    }
    
    func display(photoReferenceUrl: URL) {
        self.photoImageView.image = UIImage(named: "noImage")
        ImageDownloadHelper.shared.downloadImage(url: photoReferenceUrl) { image in
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
    }    
}

extension Photo {
    var photoReferenceUrl: URL? {
        return URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=320&photo_reference=\(self.photoReference)&key=AIzaSyBPUsycPYmVE2Nkccw7z0IliWM_i80YzZQ")
    }
}
