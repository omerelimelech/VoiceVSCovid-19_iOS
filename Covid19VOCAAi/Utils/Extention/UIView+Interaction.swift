//
//  UIView+Interaction.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 09.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

extension UIView {
    
    func animateTapResponse(desiredTrandsform: CGAffineTransform = CGAffineTransform(scaleX: 0.98, y: 0.98), initialAnimationDuration: TimeInterval = 0.1, enclosingAnimationDuration: TimeInterval = 0.1, isReturnable: Bool = true)
    {
        UIView.animate(withDuration: initialAnimationDuration,
                       delay: 0,
                       options: [.beginFromCurrentState],
                       animations: {
                        self.transform = desiredTrandsform
        }) { (_) in
            guard isReturnable else { return }
            UIView.animate(withDuration: enclosingAnimationDuration,
                           delay: 0,
                           options: [.beginFromCurrentState],
                           animations: {
                            self.transform = .identity
            }, completion: nil)
        }
    }
}
