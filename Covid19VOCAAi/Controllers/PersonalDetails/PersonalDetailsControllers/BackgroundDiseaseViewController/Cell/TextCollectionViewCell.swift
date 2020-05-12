//
//  TextCollectionViewCell.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class TextCollectionViewCell: UICollectionViewCell {

    static let reuseId = "TextCollectionViewCell"
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.backgroundColor = .purpleBlue
                self.labelText.font = UIFont(name: "OpenSansHebrew-Bold", size: 16)
                self.labelText.textColor = .white
            }else{
                self.backgroundColor = .white
                self.labelText.font = UIFont(name: "OpenSansHebrew-Regular", size: 16)
                self.labelText.textColor = .purpleBlue
            }
            
            layoutIfNeeded()
        }
    }
    @IBOutlet weak var labelText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        labelText.transform = CGAffineTransform(scaleX: -1, y: 1) // if isRTL
    }

}
