//
//  RecorderViewController+Animation.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 14/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

typealias optionalCompletion = (() -> Void)?
extension RecordViewController {
    
    private struct Constants {
        static let buttonContainerScaleBig: CGFloat = 1.3
        static let buttonContainerScaleSmall: CGFloat = 0.74
        static let audioVisualizeDefaultPadding: CGFloat = 15
        static let audioVisualLeading: CGFloat = 30 + 24 + 8
        static let audioVisualTrailing: CGFloat = 80
        static let animationTime: TimeInterval = 0.5
        static let defaultScale: CGFloat = 1
        
    }
    
    func indicateIsRecording(completion: optionalCompletion = nil){
        audioVisualization.reset()
        
        UIView.animate(withDuration: Constants.animationTime, animations:  {
            self.continueButton.alpha = .hide
            // Button layout
            self.buttonContainer.transform = CGAffineTransform(scaleX: Constants.buttonContainerScaleBig, y: Constants.buttonContainerScaleBig)
            self.recordButton.transform = CGAffineTransform(scaleX: Constants.defaultScale/Constants.buttonContainerScaleBig,
                y: Constants.defaultScale/Constants.buttonContainerScaleBig)
            
            self.buttonContainer.center = self.recordButtonOriginalCenter
            
            // Player layout
            self.playButton.alpha = .hide
            self.recordLineView.alpha = .show
            self.audioVisualization.alpha = .show
            self.visualizeLeading.constant = Constants.audioVisualizeDefaultPadding
            self.visualizeTrailing.constant = Constants.audioVisualizeDefaultPadding
            
            
            // Instruction and view
            self.preInstructionLabel.isHidden = true
            self.recordContainer.isHidden = false
            self.recordInstructionLabel.alpha = .hide
            
            self.view.layoutIfNeeded()
        }, completion: { (b) in
            completion?()
        })
    }
    
    func indicateIsStoppedRecord(completion: optionalCompletion = nil){
        let point =  CGPoint(x: self.soundStackView.frame.width - 5, y: self.soundStackView.center.y)
        let relative = soundStackView.superview?.convert(point, to: nil)
        UIView.animate(withDuration: Constants.animationTime, animations: {
            //Button layout
            self.continueButton.alpha = .show
            self.buttonContainer.transform = CGAffineTransform(scaleX: Constants.defaultScale, y: Constants.defaultScale)
            self.recordButton.transform = CGAffineTransform(scaleX: Constants.defaultScale, y: Constants.defaultScale)
            self.buttonContainer.center = relative!
            self.buttonContainer.transform = CGAffineTransform(scaleX: Constants.buttonContainerScaleSmall, y: Constants.buttonContainerScaleSmall)
            
            // Player layout
            self.visualizeLeading.constant = Constants.audioVisualLeading
            self.visualizeTrailing.constant = Constants.audioVisualTrailing
            self.playButton.alpha = .show
            self.recordLineView.alpha = .hide
     
            // instruction
            self.continueFlowInstructionLabel.alpha = .show
            self.view.layoutIfNeeded()
        }) { (b) in
            completion?()
        }
    }
    
}
extension CGFloat{
    static var show: CGFloat {
        return 1
    }
    static var hide: CGFloat{
        return 0
    }
}

extension UIView {

    public func removeAllConstraints() {
        var _superview = self.superview

        while let superview = _superview {
            for constraint in superview.constraints {

                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }

                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }

            _superview = superview.superview
        }

        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
}
