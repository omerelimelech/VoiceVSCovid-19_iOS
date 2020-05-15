//
//  ActionButtonCell.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

protocol ActionButtonCellDelegate: class {
    func actionButtonDidTap(cell: ActionButtonCell, button: GradientButton)
}

class ActionButtonCell: UITableViewCell {
    
    static let ReuseIdentifier = StringHelper.stringForClass(ActionButtonCell.self)

    @IBOutlet weak var actionButton: GradientButton!
    
    weak var delegate: ActionButtonCellDelegate?
    
    @IBAction func actionButtonDidTap(_ sender: UIButton) {
        sender.animateTapResponse()
        delegate?.actionButtonDidTap(cell: self, button: actionButton)
    }
}
