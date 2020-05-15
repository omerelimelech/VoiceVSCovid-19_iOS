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
                self.backgroundColor = UIColor.purpleBlue.withAlphaComponent(0.2)
            }else{
                self.backgroundColor = .white
            }
            selectionButton.isSelected = isSelected
            selectionButton.select()
        }
    }
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var selectionButton: RadioButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
