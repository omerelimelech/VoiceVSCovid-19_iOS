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
    case dailyQuestionnaire(full_flow:Bool)
    case dailyQuestionnaire2
    case dailyQuestionnaire3
    case voiceExplainer
    case voiceRecording(instruction: RecordInstructions, number: Int)
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
            case .dailyQuestionnaire(let full_flow):
                return DailyQuestionsViewController.initialization(full_flow:full_flow)!
            case .dailyQuestionnaire2:
                return ExperienceSymptomsViewController.initialization()
            case .dailyQuestionnaire3:
                return SympthomsViewController.initialization()
            case .voiceExplainer:
                return RecordExplainerViewController.initialization()
            case .voiceRecording(let instruction, let number):
                return RecordViewController.initialization(instructions: instruction, recordNumber: number)!
            case .finishRecordScreen:
                return FinishViewController.initialization()
            case .notificationScreen:
                return NotificationViewController.initialization()
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
