//
//  SelectionTableViewCell.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class SelectionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    static let reuseId = "SelectionTableViewCell"
    
    @IBOutlet weak var selectionView: UIView!
    override var isSelected: Bool{
        didSet{
            selectionView.backgroundColor = isSelected ? .blue : .clear
        }
    }
    
    var localizedTitle: LocalizedEnum?{
        didSet{
            self.titleLabel.text = localizedTitle?.localizedString()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let g = UITapGestureRecognizer(target: self, action: #selector(checkBoxTapped(_:)))
        selectionStyle = .none
        addGestureRecognizer(g)
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func checkBoxTapped(_ sender: UITapGestureRecognizer) {
        self.isSelected = !self.isSelected
    }
    
}
