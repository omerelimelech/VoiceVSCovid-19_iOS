//
//  VoiceUpRouter.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 11/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

enum VoiceUpNavigation: Navigation {
    case onBoarding
    case homeScreen
    case personalDetails
    case dailyQuestionnaire
    case voiceExplainer
    case voiceRecording
    case finishRecordScreen
    case notificationScreen
}


struct VoiceUpAppNavigation: AppNavigation {

    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? VoiceUpNavigation {
            switch navigation {
            case .onBoarding:
                return OnBoardingPageViewController.initialization()
            case .homeScreen:
                return UIViewController()
            case .personalDetails:
                return PersonalDetailsViewController.initialization()
            case .dailyQuestionnaire:
                return UIViewController()
            case .voiceExplainer:
                return UIViewController()
            case .voiceRecording:
                let ins = RecordInstructions(stage: .cough)
                return RecordViewController.initialization(instructions: ins, recordNumber: 1)!
            case .finishRecordScreen:
                return UIViewController()
            case .notificationScreen:
                return UIViewController()
            }
        }
        return UIViewController()
    }

    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
      from.navigationController?.pushViewController(to, animated: true)
    }
}


extension UIViewController {

    func navigate(_ navigation: VoiceUpNavigation) {
        navigate(navigation as Navigation)
    }
}
