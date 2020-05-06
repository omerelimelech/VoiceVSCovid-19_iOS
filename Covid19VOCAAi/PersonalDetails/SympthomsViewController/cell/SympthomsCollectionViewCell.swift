//
//  SympthomsCollectionViewCell.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 04/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit
import Kingfisher
import SVGKit

class SympthomsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    
    static let reuseId = "SympthomsCollectionViewCell"
    
    @IBOutlet weak var sympthomLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(withElement element: JSONExtraDatum?){
        guard let element = element else {return}
        self.sympthomLabel.text = element.optionName
        
        DispatchQueue.global(qos: .background).async {
              let image = SVGKFastImageView(svgkImage: SVGKImage(source: SVGKSource(inputSteam: InputStream(url: URL(string: element.optionImage)!))))
            DispatchQueue.main.async {
                if let image = image?.image {
                    self.imageView.image = image.uiImage
                }
            }
        }
    }

}


