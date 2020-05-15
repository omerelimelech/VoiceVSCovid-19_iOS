//
//  HapticFeedbackHelper.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 15.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

final class HapticFeedbackHelper
{
    static var shared = HapticFeedbackHelper()
    private init() { }
    
    func generateImpactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle)
    {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: style)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
    
    func generateSelectionFeedback()
    {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    func generateNotificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType)
    {
        let notificationFeedbackGenerator = UINotificationFeedbackGenerator()
        notificationFeedbackGenerator.prepare()
        
        notificationFeedbackGenerator.notificationOccurred(type)
    }
}
